package com.example.metronome

import android.media.AudioAttributes
import android.media.AudioFormat
import android.media.AudioManager
import android.media.AudioTrack
import kotlin.concurrent.fixedRateTimer
import kotlin.math.PI
import kotlin.math.sin

class MetronomeEngine {
    private val sampleRate = 44100
    private val duration = 0.01
    private val frameCount = (sampleRate * duration).toInt()
    private var clickBuffer: ShortArray = ShortArray(frameCount)
    private var audioTrack: AudioTrack? = null
    private var timer: java.util.Timer? = null
    private var bpm: Int =170;
    var isPlaying: Boolean = false

    init {
        initClickSound()
        initAudioTrack()
    }

    private fun initClickSound() {
        val amplitude = 32767.0
        val frequency = 1000.0

        for (frame in 0 until frameCount) {
            val sample = (amplitude * sin(2.0 * PI * frequency * frame / sampleRate)).toInt()
            clickBuffer?.set(frame, sample.toShort())
        }
    }

    private fun initAudioTrack(){
        val bufferSize = AudioTrack.getMinBufferSize(sampleRate, AudioFormat.CHANNEL_OUT_MONO, AudioFormat.ENCODING_PCM_16BIT)

        val audioAttributes = AudioAttributes.Builder()
            .setUsage(AudioAttributes.USAGE_MEDIA) // 미디어 재생 용도로 사용
            .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC) // 음악 재생용
            .build()

        val audioFormat = AudioFormat.Builder()
            .setSampleRate(sampleRate)
            .setEncoding(AudioFormat.ENCODING_PCM_16BIT)
            .setChannelMask(AudioFormat.CHANNEL_OUT_MONO)
            .build()

        audioTrack = AudioTrack.Builder()
            .setAudioAttributes(audioAttributes)
            .setAudioFormat(audioFormat)
            .setBufferSizeInBytes(bufferSize)
            .setTransferMode(AudioTrack.MODE_STREAM)
            .build()

        audioTrack?.write(clickBuffer, 0, clickBuffer.size)
    }

    fun play(bpm: Int) {
        if(isPlaying){
                return
        }
        isPlaying = true

        audioTrack?.play()
        val interval = 60.0 / bpm
        timer = fixedRateTimer(period = (interval * 1000).toLong()) {
            clickBuffer?.let { buffer ->
                audioTrack?.write(buffer, 0, buffer.size)
            }
        }
    }

    fun stop() {
        isPlaying = false
        timer?.cancel()
        timer = null
        audioTrack?.stop()
    }
    fun setBPM(bpm: Int){
        this.bpm = bpm
    }

    fun getBPM():Int{
        return bpm
    }
}
