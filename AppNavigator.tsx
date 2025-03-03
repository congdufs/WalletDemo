import { createNativeStackNavigator } from '@react-navigation/native-stack';
import App from './App';
import CurrencySelection from './CurrencySelection';
import type { RootStackParamList } from './navigation';

const Stack = createNativeStackNavigator<RootStackParamList>();

export const AppNavigator = () => (
  <Stack.Navigator>
    <Stack.Screen
      name="App"
      component={App}
      options={{ headerShown: false }}
    />
    <Stack.Screen
      name="CurrencySelection"
      component={CurrencySelection}
      options={{ title: 'Currency Selection' }}
    />
  </Stack.Navigator>
);