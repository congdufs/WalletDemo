import React, { useState } from 'react';
import {
  SafeAreaView,
  View,
  Text,
  FlatList,
  TouchableOpacity,
  Image,
  StyleSheet,
  NativeEventEmitter,
  NativeModules
} from 'react-native';
import { useNavigation, useRoute } from '@react-navigation/native';
import type { CurrencySelectionProps }  from './navigation';

type Currency = {
  symbol: string;
  name: string;
  code: string;
};

const currencies: Currency[] = [
  {
    symbol: '$',
    name: 'US Dollar',
    code: 'USD',
  },
  {
    symbol: '$',
    name: 'Hong Kong',
    code: 'HKD',
  },
];

type CurrencyParams = {
  currentCurrency: string;
};

interface CurrencySelectionProps {
  route: RouteProp<{ params: CurrencyParams }, 'params'>;
}

const { ReactNativeBridgeModule } = NativeModules;

function CurrencySelection({}: CurrencySelectionProps) {
  const route = useRoute(); 
  const { currentCurrency } = route.params || {};
  const [selectedCurrency, setSelectedCurrency] = useState<Currency>(currentCurrency || currencies[0]);
  const navigation = useNavigation<CurrencySelectionProps['navigation']>();

  const notifyNative = () => {
    console.log("test000")
    console.log(ReactNativeBridgeModule)
    ReactNativeBridgeModule.handleEventFromRN("selectdCurrency", {"symbol": selectedCurrency.symbol, "name": selectedCurrency.name, "code": selectedCurrency.code});
  };

  return (
    <SafeAreaView style={styles.container}>
      <FlatList
        data={currencies}
        keyExtractor={(item) => item.code}
        renderItem={({ item }) => (
          <TouchableOpacity 
            style={[
              styles.currencyItem,
              // { backgroundColor: item.code === selectedCurrency.code ? '#f0f4ff' : '#fff' }
            ]}
            onPress={() => setSelectedCurrency(item)}
          >
            <Text style={styles.currencySymbol}>{item.symbol}</Text>
            <Text style={styles.currencyName}>{item.name} ({item.code})</Text>
            {selectedCurrency.code === item.code && (
              <Image 
              source={require('./assets/images/selected.png')} 
              style={styles.iconImage} 
              />
            )}
          </TouchableOpacity>
        )}
        ListHeaderComponent={() => (
          <Text style={styles.description}>
            Select your preferred display currency. Your display currency is used to provide a fiat equivalence for your crypto balances
          </Text>
        )}
      />
      
      <TouchableOpacity 
        style={styles.confirmButton}
        onPress={() => {
          navigation.navigate('App', { currency: selectedCurrency });
          notifyNative()
        }}
      >
        <Text style={styles.confirmButtonText}>Confirm</Text>
      </TouchableOpacity>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 24,
    backgroundColor: '#fff',
  },
  description: {
    fontSize: 14,
    color: '#666666',
    paddingHorizontal: 24,
    paddingVertical: 12,
    marginBottom: 12,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#007bff',
    marginBottom: 16,
  },
  subtitle: {
    fontSize: 16,
    color: '#666',
    marginBottom: 28,
  },
  currencyItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 16,
    marginHorizontal: 24,
    borderRadius: 8,
    marginVertical: 8,
    backgroundColor: '#f0f4ff'
  },
  textContainer: {
    flex: 1,
  },
  currencySymbol: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#007bff',
  },
  currencyName: {
    marginLeft: 8,
    fontSize: 16,
  },
  confirmButton: {
    backgroundColor: '#007bff',
    paddingVertical: 12,
    marginHorizontal: 24,
    borderRadius: 8,
    marginTop: 32,
  },
  confirmButtonText: {
    color: '#fff',
    fontSize: 18,
    textAlign: 'center',
    fontWeight: 'bold',
  },
  iconImage: {
    width: 20,
    height: 20,
    resizeMode: 'contain',
    marginLeft: 'auto', 
    marginRight: 12,
  },
});

export default CurrencySelection;