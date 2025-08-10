package com.solvro.topwr.widget.parking.receiver

import com.solvro.topwr.widget.GlanceParkingWidget
import HomeWidgetGlanceWidgetReceiver
import com.solvro.topwr.widget.parking.ParkingSymbol


class WroParkingWidgetReceiver : HomeWidgetGlanceWidgetReceiver<GlanceParkingWidget>() {
    override val glanceAppWidget = GlanceParkingWidget(ParkingSymbol.WRO)
}