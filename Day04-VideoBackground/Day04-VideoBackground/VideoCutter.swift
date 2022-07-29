//
//  VideoCutter.swift
//  Day04-VideoBackground
//
//  Created by 刘观华 on 2022/7/29.
//

import Foundation
import UIKit
import AVFoundation

extension String {
    var convert: NSString { return (self as NSString) }
}

class VideoCutter:NSObject{
    /**
     Block based method for crop video url
     
     @param videoUrl Video url
     @param startTime The starting point of the video segments
     @param duration Total time, video length
     
     */
    func cropVideoWithUrl(videoUrl url:URL , startTime:CGFloat,duration:CGFloat,completion:((_ videoPath:URL?,_ error:NSError?)->Void)?){
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            let asset = AVURLAsset(url:url , options: nil)
            let exportSession = AVAssetExportSession(asset: asset, presetName: "AVAssetExportPresetHighestQuality")
            let paths:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
            var outputURL = paths.object(at: 0)as! String;
            let manager = FileManager.default
            // 异常处理：
            // try?: 将错误转化成可选异常,有错误发生时返回nil
            // try!: 禁用错误传递，当确认无异常发生时使用，否则可能会发生运行时异常
            // defer: 在即将离开当前代码块时执行一系列语句,延迟执行的语句不能包含任何控制转移语句，例如break、return语句，或是抛出一个错误。
            // defer语句是从后往前执行
            do{
                try manager.createDirectory(at: URL(fileURLWithPath: outputURL), withIntermediateDirectories: true, attributes: nil)
            }catch _{
                
            }
            outputURL = outputURL.convert.appendingPathComponent("output.mp4")
            do{
                try manager.removeItem(atPath: outputURL)
            }catch _{
                
            }
            
            if let exportSession = exportSession as AVAssetExportSession?{
                exportSession.outputURL = URL(fileURLWithPath: outputURL)
                exportSession.shouldOptimizeForNetworkUse = true
                exportSession.outputFileType = AVFileType.mp4
                let start = CMTimeMakeWithSeconds(Float64(startTime), preferredTimescale: 600)
                let duration = CMTimeMakeWithSeconds(Float64(duration), preferredTimescale: 600)
                let range = CMTimeRangeMake(start: start, duration: duration)
                exportSession.timeRange = range
                
                exportSession.exportAsynchronously {
                    switch exportSession.status {
                        case AVAssetExportSession.Status.completed:
                            completion?(exportSession.outputURL, nil)
                        case AVAssetExportSession.Status.failed:
                            print("Failed: \(String(describing: exportSession.error))")
                        case AVAssetExportSession.Status.cancelled:
                            print("Failed: \(String(describing: exportSession.error))")
                        default:
                            print("default case")
                    }
                }
            }
        }
    }
    
    // iOS8废弃,使用DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async{}替代
    //    let priority = DispatchQueue.GlobalQueuePriority.default
    //    DispatchQueue.global(priority: priority).async {
    //
    //    }
}
