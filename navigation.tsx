import type { NativeStackScreenProps } from '@react-navigation/native-stack';

export type RootStackParamList = {
  App: undefined;
  CurrencySelection: { currentCurrency: string };
};

// 屏幕组件 Props 类型
export type AppScreenProps = NativeStackScreenProps<RootStackParamList, 'App'>;
export type CurrencySelectionProps = NativeStackScreenProps<RootStackParamList, 'CurrencySelection'>;