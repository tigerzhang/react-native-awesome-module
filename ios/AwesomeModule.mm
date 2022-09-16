#import "AwesomeModule.h"

#ifdef RCT_NEW_ARCH_ENABLED
#import "RNAwesomeModuleSpec.h"
#endif

@implementation AwesomeModule
RCT_EXPORT_MODULE()

// Example method
// See // https://reactnative.dev/docs/native-modules-ios
RCT_REMAP_METHOD(multiply,
                 multiplyWithA:(double)a withB:(double)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
  NSNumber *result = @(a * b);

  resolve(result);
}

RCT_REMAP_METHOD(getSkrtBleKey,
                 key:(NSString*)key len:(int)len
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
    NSString* bleKey = @"abc";

    resolve(bleKey);
}

typedef UInt8 u8;

// C 常数密钥
u8 C[4]={0x73,0x6B,0x79,0x23};

// D[] 传入的蓝牙MAC地址  Result 返回密钥
void Formula_16(u8 *D,u8 *Result)
{
    Result[0] = D[0] + C[0] - D[1] + D[2];
    Result[1] = D[1] + D[5] - D[4] ;
    Result[2] = D[2] + D[1];
    Result[3] = D[3] & D[4];

    Result[4] = D[0] + C[1] - D[4] ;
    Result[5] = ((D[1] & D[2]) ^ D[5]) | D[4];
    Result[6] = D[2] |( C[2] ^ D[4] ^ D[1] ^ D[5] );
    Result[7] = ((D[3] - D[2] + D[5] )& D[1]) ^ D[5] ;

    Result[8] = D[0] + D[4] + D[3];
    Result[9] = (D[1] & C[1]) ^ (D[5] + D[3]);
    Result[10] = D[2] | (C[2] ^ (D[3] + D[4] + D[0]));
    Result[11] = D[3] - C[3] + D[4] + D[1];

    Result[12] = (D[0] + C[0] - D[1]) | (D[2] ^ (D[4] & D[3]));
    Result[13] = (D[1] + D[5] - D[3]) | (C[2] ^ (D[2] & C[1]));
    Result[14] = D[2] + D[4];
    Result[15] = D[3] + D[4];
}

RCT_REMAP_METHOD(getSkrtBleKeyArray,
                 keyArray:(NSArray*)key len:(int)len
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
    NSLog(@"array: %@", key);

    NSArray* bleKey = @[@0x01, @0x02, @0x03, @4];

    u8 result[16];
    u8 keyArr[6];
    for (int i = 0; i < 6; i++) {
        keyArr[i] = [[key objectAtIndex:i] intValue];
    }
    Formula_16(keyArr, result);


    NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity: 16];
    if (array) {
        for (int i = 0; i < 16; i++) {
            [array addObject: [NSNumber numberWithUnsignedChar:result[i]]];
        }
    }

    resolve(array);
}

// Don't compile this code when we build for the old architecture.
#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeAwesomeModuleSpecJSI>(params);
}
#endif

@end
