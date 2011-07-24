package
{
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.net.URLRequest;

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

        //初始化LoaderQueue，2线程， 延迟100毫秒
        loaderQueue = new LoaderQueue(2, 100, true);
        
        //初始化LoaderInspector，并添加到舞台
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
        loaderQueue.addItem(pic1);
        
        //使用URLLoader
        loaderQueue.addItem(
            new URLLoaderAdapter(1, new URLRequest("images/pic2.jpg")));
        
        //使用URLStream
        loaderQueue.addItem(
            new URLStreamAdapter(2, new URLRequest("images/pic3.jpg")));
        
        //使用BackupLoader
        loaderQueue.addItem(
            new BackupLoaderAdapter(2, new URLRequest("error_file.jpg"), 
                new URLRequest("images/pic4.jpg")));
        
        //加载错误的文件
        loaderQueue.addItem(
            new URLLoaderAdapter(4, new URLRequest("error_file.jpg")));
    }
}
}