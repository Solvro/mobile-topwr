package com.solvro.topwr.widget

import HomeWidgetGlanceState
import HomeWidgetGlanceStateDefinition
import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.core.graphics.drawable.toBitmap
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.provideContent
import androidx.glance.currentState
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.fillMaxSize
import coil3.Bitmap
import coil3.asDrawable
import coil3.imageLoader
import coil3.request.ErrorResult
import coil3.request.ImageRequest
import coil3.request.SuccessResult
import com.solvro.topwr.widget.parking.ParkingSymbol
import com.solvro.topwr.widget.parking.model.ParkingWidgetData
import com.solvro.topwr.widget.parking.ui.ParkingWidgetContent
import kotlinx.serialization.SerializationException
import kotlinx.serialization.json.Json

private const val PARKING_WIDGET_DATA_KEY = "parking_home_screen_widget_data"

class GlanceParkingWidget(
    val parkingSymbol: ParkingSymbol,
) : GlanceAppWidget() {

    override val stateDefinition = HomeWidgetGlanceStateDefinition()


    override suspend fun provideGlance(
        context: Context,
        id: GlanceId
    ) {
        provideContent {
            GlanceContent(context, currentState())
        }
    }

    @Composable
    private fun GlanceContent(context: Context, currentState: HomeWidgetGlanceState) {
        val prefs = currentState.preferences

        val parkingJson = prefs.getString(PARKING_WIDGET_DATA_KEY, "") ?: ""
        val parkingWidget = decodeParkingWidgetFromJsonString(parkingJson, parkingSymbol)

        var parkingImage by remember(parkingWidget.imageUrl) {
            mutableStateOf<ImageResource>(
                ImageResource.Loading
            )
        }

        LaunchedEffect(parkingWidget.imageUrl) {
            val bitmap = context.createBitmapFromImageUrl(parkingWidget.imageUrl)
            parkingImage = if (bitmap != null) {
                ImageResource.Success(bitmap)
            } else {
                ImageResource.Error
            }
        }
        Box(
            contentAlignment = Alignment.Center,
            modifier = GlanceModifier
                .fillMaxSize()
        ) {
            ParkingWidgetContent(
                parkingImage = parkingImage,
                parkingSymbol = parkingWidget.symbol,
                numberOfFreePlaces = parkingWidget.freePlaces,
                trend = parkingWidget.trend.toInt()
            )
        }
    }

    private fun decodeParkingWidgetFromJsonString(
        parkingJsonString: String,
        parkingSymbol: ParkingSymbol
    ): ParkingWidgetData {
        val parkingList: List<ParkingWidgetData> = Json.decodeFromString(parkingJsonString)
        return parkingList.firstOrNull { it.symbol == parkingSymbol.symbol }
            ?: throw SerializationException("Parking with given symbol not found")
    }

    private suspend fun Context.createBitmapFromImageUrl(url: String): Bitmap? {
        val request = ImageRequest.Builder(this).data(url)
            .size(width = 1850, height = 720)
            .build()

        return when (val result = imageLoader.execute(request)) {
            is ErrorResult -> return null
            is SuccessResult -> result.image.asDrawable(resources).toBitmap()
        }
    }
}


sealed class ImageResource {
    object Loading : ImageResource()
    data class Success(val bitmap: Bitmap) : ImageResource()
    object Error : ImageResource()
}