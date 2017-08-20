//: Playground - noun: a place where people can play

import AVFoundation
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

let player = AVAudioPlayerNode()
let audioFormat = player.outputFormat(forBus: 0)

let sampleRate = Float(audioFormat.sampleRate)
let length = 3 * sampleRate

let buffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: UInt32(44100))
buffer.frameLength = UInt32(sampleRate)

let channels = Int(audioFormat.channelCount)
for ch in (0..<channels) {
    let samples = buffer.floatChannelData?[ch]
    for n in 0..<Int(buffer.frameLength) {
        samples?[n] = sinf(Float(2.0 * M_PI) * 440.0 * Float(n) / sampleRate)
        
    }
}

let audioEngine = AVAudioEngine()

// オーディオエンジンにプレイヤーをアタッチ
audioEngine.attach(player)
let mixer = audioEngine.mainMixerNode
// プレイヤーノードとミキサーノードを接続
audioEngine.connect(player, to: mixer, format: audioFormat)
// 再生の開始を設定
player.scheduleBuffer(buffer) {
    print("Play completed")
}

do {
    // エンジンを開始
    try audioEngine.start()
    // 再生
    player.play()
    
} catch let error {
    print(error)
}