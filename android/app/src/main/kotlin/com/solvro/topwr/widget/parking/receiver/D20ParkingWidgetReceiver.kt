package com.solvro.topwr.widget.parking.receiver

import HomeWidgetGlanceWidgetReceiver
import com.solvro.topwr.widget.GlanceParkingWidget
import com.solvro.topwr.widget.parking.ParkingSymbol

class D20ParkingWidgetReceiver : HomeWidgetGlanceWidgetReceiver<GlanceParkingWidget>() {
    override val glanceAppWidget = GlanceParkingWidget(ParkingSymbol.D20)
}