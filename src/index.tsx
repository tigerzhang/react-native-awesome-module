import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-awesome-module' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

const AwesomeModule = NativeModules.AwesomeModule ? NativeModules.AwesomeModule
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function multiply(a: number, b: number): Promise<number> {
  return AwesomeModule.multiply(a, b);
}
export function getSkrtBleKey(key: string, len: number): Promise<string> {
  return AwesomeModule.getSkrtBleKey(key, len);
}
export function getSkrtBleKeyArray(key: Array<number>, len: number): Promise<Array<number>> {
  return AwesomeModule.getSkrtBleKeyArray(key, len);
}
