package cn.com.wanyueliang.tomato.utils.ffmpeg.demo;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;

import java.io.File;

import cn.com.wanyueliang.tomato.utils.ffmpeg.R;
import cn.com.wanyueliang.tomato.utils.ffmpeg.VideoTrimmer;

public class VideoTrimmerDemoActivity extends Activity {

    public static final String TAG = "BJX";

    VideoTrimmer mVideoTrimmer;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        mVideoTrimmer = new VideoTrimmer(this);

        findViewById(R.id.startBtn).setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                new Thread(new Runnable() {

                    @SuppressLint("SdCardPath")
                    @Override
                    public void run() {

                        Log.e(TAG, "run: 开始" );
                        String input = "/storage/emulated/0/herve/haitao.mp4";
                        File file=new File(input);
                        if(file.exists()){

                            Log.e(TAG, "run: 存在" );
                        }else {
                            Log.e(TAG, "run: 不存在" );

                        }
//						String output = "/storage/emulated/0/herve/haitao_crop_001.mp4";
//						boolean result = mVideoTrimmer.trim(input,output,"0.3","3.1");
                        String output = "/storage/emulated/0/herve/haitao_crop_002.mp4";
                        boolean result = mVideoTrimmer.trim(1, input, output, "3.4", "3.3");
                        if (result) {
                            Log.e(TAG, "OK");
                        } else {
                            Log.e(TAG, "NG");
                        }
                    }
                }).start();
            }
        });
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
    }
}