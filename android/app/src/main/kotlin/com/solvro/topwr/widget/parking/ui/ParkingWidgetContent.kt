package com.solvro.topwr.widget.parking.ui

import android.annotation.SuppressLint
import androidx.annotation.DrawableRes
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.ColorFilter
import androidx.glance.GlanceModifier
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.appwidget.CircularProgressIndicator
import androidx.glance.background
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.padding
import androidx.glance.layout.size
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextStyle
import androidx.glance.unit.ColorProvider
import com.solvro.topwr.R
import com.solvro.topwr.widget.ImageResource


private val WIDGET_SIZE = 125.dp
private val WHITE_SOAP = Color(0xFFFFFDFC)
private val BLACK_MIRAGE = Color(0xFF293241)
private val ORANGE_POMEGRANADE = Color(0xFFE43D32)

@SuppressLint("RestrictedApi")
@Composable
fun ParkingWidgetContent(
    parkingImage: ImageResource,
    parkingSymbol: String,
    numberOfFreePlaces: String,
    trend: Int,
) {

    if (parkingImage is ImageResource.Loading) {
        CircularProgressIndicator(
            color = ColorProvider(
                ORANGE_POMEGRANADE
            )
        )
    } else
        Box(
            contentAlignment = Alignment.Companion.Center,
            modifier = GlanceModifier.Companion.size(WIDGET_SIZE)
                .then(
                    if (parkingImage is ImageResource.Success) {
                        GlanceModifier.background(
                            ImageProvider(parkingImage.bitmap),
                            colorFilter = ColorFilter.Companion.tint(
                                ColorProvider(
                                    Color(0x40222222)
                                )
                            )
                        )
                    } else {
                        GlanceModifier.background(BLACK_MIRAGE)
                    }
                )
        )
        {
            Box(
                GlanceModifier.Companion.fillMaxSize(),
                contentAlignment = Alignment.Companion.TopStart
            ) {
                Text(
                    modifier = GlanceModifier.Companion.padding(8.dp),
                    text = parkingSymbol,
                    style = TextStyle(
                        fontSize = 24.sp,
                        fontWeight = FontWeight.Companion.Bold,
                        color = ColorProvider(WHITE_SOAP),
                    )
                )
            }
            Box(
                GlanceModifier.Companion.fillMaxSize(),
                contentAlignment = Alignment.Companion.BottomStart
            ) {
                Image(
                    modifier = GlanceModifier.Companion.padding(start = 8.dp).size(50.dp),
                    contentDescription = null,
                    provider = ImageProvider(determineTrendIcon(trend = trend)),
                )
            }
            Box(
                GlanceModifier.Companion.fillMaxSize(),
                contentAlignment = Alignment.Companion.BottomEnd
            ) {
                Text(
                    modifier = GlanceModifier.Companion.padding(bottom = 8.dp, end = 8.dp),
                    text = numberOfFreePlaces,
                    style = TextStyle(
                        fontSize = 24.sp,
                        fontWeight = FontWeight.Companion.Bold,
                        color = ColorProvider(WHITE_SOAP),
                    )
                )
            }
        }
}

@DrawableRes
private fun determineTrendIcon(trend: Int): Int {
    return when (trend) {
        1 -> R.drawable.up_trend
        -1 -> R.drawable.down_trend
        0 -> R.drawable.const_trend
        else -> R.drawable.no_trend
    }
}