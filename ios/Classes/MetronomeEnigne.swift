import AVFoundation


class MetronomeEngine{
    private let audioEngine = AVAudioEngine()
    private let clickNode = AVAudioPlayerNode()
    private let format: AVAudioFormat
    private var clickBuffer: AVAudioPCMBuffer?
    private var timer: Timer?
    public var isPlaying: Bool = false
    init() {
        audioEngine.attach(clickNode)
        format = audioEngine.mainMixerNode.outputFormat(forBus: 0)
        audioEngine.connect(clickNode, to: audioEngine.mainMixerNode, format: format)
        loadClickSound()
    }

    private func loadClickSound() {
        let sampleRate = format.sampleRate
        let duration: Double = 0.01 // duration of the click sound in seconds
        let frameCount = AVAudioFrameCount(sampleRate * duration)

        clickBuffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount)
        clickBuffer?.frameLength = frameCount

        let clickData = clickBuffer?.floatChannelData?[0]
        let amplitude: Float = 1.0
        let frequency: Float = 1000.0 // 1kHz click

        for frame in 0..<Int(frameCount) {
            let sample = amplitude * sinf(2.0 * Float.pi * frequency * Float(frame) / Float(sampleRate))
            clickData?[frame] = sample
        }
    }

    func play(bpm: Int) {
        if(isPlaying){
            return
        }
        do {
            try audioEngine.start()
        } catch {
            print("Error starting the audio engine: \(error.localizedDescription)")
            return
        }
        isPlaying = true
        clickNode.scheduleBuffer(clickBuffer!, at: nil, options: .loops, completionHandler: nil)
        let interval = 60.0 / Double(bpm)
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.clickNode.stop()
            self.clickNode.play()
            self.clickNode.scheduleBuffer(self.clickBuffer!, at: nil, options: .interrupts, completionHandler: nil)
        }
    }

    func stop() {
        isPlaying = false
        timer?.invalidate()
        timer = nil
        clickNode.stop()
        audioEngine.stop()
    }

}
