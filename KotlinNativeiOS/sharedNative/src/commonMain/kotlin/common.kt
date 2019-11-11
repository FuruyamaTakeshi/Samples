package org.kotlin.mpp.mobile

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.*
import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.http.*
import kotlinx.coroutines.*

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

internal expect val ApplicationDispatcher: CoroutineDispatcher

class ApplicationApi {
    private val client = HttpClient()

    var address = Url("https://tools.ietf.org/rfc/rfc1866.txt")

    fun about(callback: (String) -> Unit) {
        GlobalScope.apply {
            launch(ApplicationDispatcher) {
                val result: String = client.get {
                    url(this@ApplicationApi.address.toString())
                }

                callback(result)
            }
        }
    }
}