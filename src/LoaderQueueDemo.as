package
{
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.net.URLRequest;

import net.manaca.loaderqueue.LoaderProgress;
import net.manaca.loaderqueue.LoaderQueue;
import net.manaca.loaderqueue.LoaderQueueEvent;
import net.manaca.loaderqueue.adapter.BackupLoaderAdapter;
import net.manaca.loaderqueue.adapter.LoaderAdapter;
import net.manaca.loaderqueue.adapter.URLLoaderAdapter;
import net.manaca.loaderqueue.adapter.URLStreamAdapter;
import net.manaca.loaderqueue.inspector.LoaderInspector;

[SWF(width="500", height="376", backgroundColor="#FFFFFF")]
public class LoaderQueueDemo extends Sprite
{
    private var loaderQueue:LoaderQueue;
    private var loaderInspector:LoaderInspector;
    
    public function LoaderQueueDemo()
    {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        //实例化LoaderQueue，2线程， 延迟100毫秒
        loaderQueue = new LoaderQueue(2, 100, true);
        
        //实例化LoaderInspector，并添加到舞台
        loaderInspector = new LoaderInspector();
        loaderInspector.loaderQueue = loaderQueue;
        stage.addChild(loaderInspector);
        
        //使用Loader
        var pic1:LoaderAdapter = 
            new LoaderAdapter(1, new URLRequest("images/pic1.jpg"));
        pic1.addEventListener(LoaderQueueEvent.TASK_COMPLETED,
            function(event:LoaderQueueEvent):void
            {
                loaderInspector.alpha = .8;
                addChild(pic1.adaptee.content);
            });
        
        //使用URLLoader
        var pic2:URLLoaderAdapter = 
            new URLLoaderAdapter(1, new URLRequest("images/pic2.jpg"));
        
        //使用URLStream
        var pic3:URLStreamAdapter = 
            new URLStreamAdapter(2, new URLRequest("images/pic3.jpg"));
        
        //使用BackupLoader
        var pic4:BackupLoaderAdapter = 
            new BackupLoaderAdapter(2, new URLRequest("error_file.jpg"), 
                new URLRequest("images/pic4.jpg"))
        
        //加载错误的文件
        var errorFile:URLLoaderAdapter = 
            new URLLoaderAdapter(4, new URLRequest("error_file.jpg"));
        
        loaderQueue.addItem(pic1);
        loaderQueue.addItem(pic2);
        loaderQueue.addItem(pic3);
        loaderQueue.addItem(pic4);
        loaderQueue.addItem(errorFile);
        
        //实例化一个LoaderProgress
        var loaderProgress:LoaderProgress = new LoaderProgress();
        //监听进度事件
        loaderProgress.addEventListener(Event.CHANGE,
            function(event:Event):void
            {
                trace(loaderProgress.totalProgress);
            });
        loaderProgress.addItem(pic1);
        loaderProgress.addItem(pic2);
        loaderProgress.addItem(pic3);
        loaderProgress.addItem(pic4);
        loaderProgress.addItem(errorFile);
        loaderProgress.start();
    }
}
}