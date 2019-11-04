package org.kotlin.mpp.mobile

fun helloWorld() {
    println("Hello World!")
}

data class UserEntity(val id: String, val name: String)
data class AnnouncementEntity(val id: String, val name: String)
data class WeightEntity(val date: String, val value: Double)