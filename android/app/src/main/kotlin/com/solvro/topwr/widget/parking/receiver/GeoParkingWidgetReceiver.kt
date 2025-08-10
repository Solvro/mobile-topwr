package com.solvro.topwr.widget.parking.receiver

import HomeWidgetGlanceWidgetReceiver
import com.solvro.topwr.widget.GlanceParkingWidget
import com.solvro.topwr.widget.parking.ParkingSymbol


class GeoParkingWidgetReceiver : HomeWidgetGlanceWidgetReceiver<GlanceParkingWidget>() {
    override val glanceAppWidget = GlanceParkingWidget(ParkingSymbol.GEO_L)
}

