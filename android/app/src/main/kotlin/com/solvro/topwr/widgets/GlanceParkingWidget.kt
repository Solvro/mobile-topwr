package com.solvro.topwr.widgets

import HomeWidgetGlanceState
import HomeWidgetGlanceStateDefinition
import android.annotation.SuppressLint
import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.graphics.drawable.toBitmap
import androidx.glance.ColorFilter
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.currentState
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.padding
import androidx.glance.layout.size
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextStyle
import androidx.glance.unit.ColorProvider
import coil3.Bitmap
import coil3.asDrawable
import coil3.imageLoader
import coil3.request.ErrorResult
import coil3.request.ImageRequest
import coil3.request.SuccessResult
import com.solvro.topwr.R
import kotlinx.serialization.json.Json


class GlanceParkingWidget(
    val parkingId: String,
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

        val parkingJson = prefs.getString(parkingId, "")!!
        val parkingWidget = decodeParkingWidgetFromJsonString(parkingJson)

        var parkingImage by remember(parkingWidget.imageUrl) { mutableStateOf<Bitmap?>(null) }

        LaunchedEffect(parkingWidget.imageUrl) {
            parkingImage = context.createBitmapFromImageUrl(parkingWidget.imageUrl)
        }

          ParkingWidgetContent(
              parkingImage = parkingImage,
              parkingSymbol = parkingWidget.symbol,
              numberOfFreePlaces = parkingWidget.freePlaces
          )

    }

    private fun decodeParkingWidgetFromJsonString(parkingJsonString: String): ParkingWidget {
        return Json.decodeFromString(parkingJsonString)
    }

    private suspend fun Context.createBitmapFromImageUrl(url: String): Bitmap? {
        val request = ImageRequest.Builder(this).data(url)
            .size(width = 1850, height = 720)
            .build()

        return when (val result = imageLoader.execute(request)) {
            is ErrorResult -> throw result.throwable
            is SuccessResult -> result.image.asDrawable(resources).toBitmap()
        }
    }

}
//TODO: add trend handling & error handling, extract function
@SuppressLint("RestrictedApi")
@Composable
fun ParkingWidgetContent(
    parkingImage: Bitmap?,
    parkingSymbol: String,
    numberOfFreePlaces: String,
) {
    if (parkingImage != null) {
        Box(
            contentAlignment = Alignment.Center,
            modifier = GlanceModifier.size(125.dp)
                .background(
                    ImageProvider(parkingImage),
                    colorFilter = ColorFilter.tint(
                        ColorProvider(
                            Color(0x40222222)
                        )
                    )
                ),
        )
        {
            Box(
                GlanceModifier.fillMaxSize(),
                contentAlignment = Alignment.TopStart
            ) {
                Text(
                    modifier = GlanceModifier.padding(8.dp),
                    text = parkingSymbol,
                    style = TextStyle(
                        fontSize = 24.sp,
                        fontWeight = FontWeight.Bold,
                        color = ColorProvider(Color(0xFFFFFDFC)),
                    )
                )
            }

            Box(
                GlanceModifier.fillMaxSize(),
                contentAlignment = Alignment.BottomStart
            ) {
                Image(
                    modifier = GlanceModifier.padding(start = 8.dp).size(50.dp),
                    contentDescription = null,
                    provider = ImageProvider(R.drawable.up_trend),
                )
            }

            Box(
                GlanceModifier.fillMaxSize(),
                contentAlignment = Alignment.BottomEnd
            ) {
                Text(
                    modifier = GlanceModifier.padding(bottom = 8.dp, end = 8.dp),
                    text = numberOfFreePlaces,
                    style = TextStyle(
                        fontSize = 24.sp,
                        fontWeight = FontWeight.Bold,
                        color = ColorProvider(Color(0xFFFFFDFC)),
                    )
                )

            }
        }
    }
}
