package com.reactnativeawesomemodule;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableNativeArray;
import com.facebook.react.module.annotations.ReactModule;

@ReactModule(name = AwesomeModuleModule.NAME)
public class AwesomeModuleModule extends ReactContextBaseJavaModule {
    public static final String NAME = "AwesomeModule";

    public AwesomeModuleModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    @NonNull
    public String getName() {
        return NAME;
    }


    // Example method
    // See https://reactnative.dev/docs/native-modules-android
    @ReactMethod
    public void multiply(double a, double b, Promise promise) {
        promise.resolve(a * b);
    }

    byte[] C={0x73,0x6B,0x79,0x23};

    // D[] 传入的蓝牙MAC地址  Result 返回密钥
    void Formula_16(byte[] D, byte[] Result)
    {
      Result[0] = (byte) (D[0] + C[0] - D[1] + D[2]);
      Result[1] = (byte) (D[1] + D[5] - D[4]);
      Result[2] = (byte) (D[2] + D[1]);
      Result[3] = (byte) (D[3] & D[4]);

      Result[4] = (byte) (D[0] + C[1] - D[4]);
      Result[5] = (byte) (((D[1] & D[2]) ^ D[5]) | D[4]);
      Result[6] = (byte) (D[2] |( C[2] ^ D[4] ^ D[1] ^ D[5] ));
      Result[7] = (byte) (((D[3] - D[2] + D[5] )& D[1]) ^ D[5]);

      Result[8] = (byte) (D[0] + D[4] + D[3]);
      Result[9] = (byte) ((D[1] & C[1]) ^ (D[5] + D[3]));
      Result[10] = (byte) (D[2] | (C[2] ^ (D[3] + D[4] + D[0])));
      Result[11] = (byte) (D[3] - C[3] + D[4] + D[1]);

      Result[12] = (byte) ((D[0] + C[0] - D[1]) | (D[2] ^ (D[4] & D[3])));
      Result[13] = (byte) ((D[1] + D[5] - D[3]) | (C[2] ^ (D[2] & C[1])));
      Result[14] = (byte) (D[2] + D[4]);
      Result[15] = (byte) (D[3] + D[4]);
    }

    @ReactMethod
    public void getSkrtBleKeyArray(ReadableArray D, int len, Promise promise) {
      byte[] result = new byte[16];
      byte[] keyArr = new byte[6];
      for (int i = 0; i < 6; i++) {
        keyArr[i] = (byte) (D.getInt(i) & 0xff);
      }

      Formula_16(keyArr, result);

      WritableArray arr = Arguments.createArray();
      for (int i = 0; i < 16; i++) {
        arr.pushInt(result[i] & 0xff);
      }
      promise.resolve(arr);
    }

    @ReactMethod
    public void sum(ReadableArray intArray, Promise promise) {
      int sum = 0;
      for (int i = 0; i < intArray.size(); i++) {
        sum += intArray.getInt(i);
      }
      promise.resolve(sum);
    }
}
