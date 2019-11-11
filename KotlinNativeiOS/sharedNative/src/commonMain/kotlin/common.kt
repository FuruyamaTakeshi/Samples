package org.kotlin.mpp.mobile

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.*

fun helloWorld() {
    println("Hello World!")
}

@Serializable data class UserEntity(
    val id: String,
    val name: String,
    val age: Int
)

@Serializable data class Announcement(val id: String, val name: String)

fun helloSerializable() {
    val json = Json(JsonConfiguration.Stable)
    val jsonData = json.stringify(UserEntity.serializer(), UserEntity("1234", "taro", 30))
    println(jsonData)
}