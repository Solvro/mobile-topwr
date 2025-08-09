package com.solvro.topwr.widget.parking.model

import kotlinx.serialization.Serializable

@Serializable
data class ParkingWidgetData(
    val symbol: String,
    val freePlaces: String,
    val imageUrl: String,
    val trend: String
)