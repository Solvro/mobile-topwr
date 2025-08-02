package com.solvro.topwr.widgets

import kotlinx.serialization.Serializable

@Serializable
data class ParkingWidget(
    val symbol: String,
    val freePlaces: String,
    val imageUrl: String,
    val trend: String
)
