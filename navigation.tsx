import type { NativeStackScreenProps } from '@react-navigation/native-stack';

export type RootStackParamList = {
  App: undefined;
  CurrencySelection: { currentCurrency: string };
};

export type AppScreenProps = NativeStackScreenProps<RootStackParamList, 'App'>;
export type CurrencySelectionProps = NativeStackScreenProps<RootStackParamList, 'CurrencySelection'>;