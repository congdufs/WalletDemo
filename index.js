import { AppRegistry } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import App from './App';
import CurrencySelection from './CurrencySelection';

const Stack = createNativeStackNavigator();

const MainStack = () => (
  <NavigationContainer>
    <Stack.Navigator>
      <Stack.Screen
        name="App"
        component={App}
        options={{ headerShown: false }} // 隐藏App页面的RN导航栏
      />
      <Stack.Screen
        name="CurrencySelection"
        component={CurrencySelection}
        options={{ title: 'Currency Selection' }} // 显示RN导航栏
      />
    </Stack.Navigator>
  </NavigationContainer>
);

AppRegistry.registerComponent('ReactNativeModule', () => MainStack);