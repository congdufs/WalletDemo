import React, { useState } from 'react';
import {
  View,
  Text,
  FlatList,
  TouchableOpacity,
  StyleSheet,
} from 'react-native';
// import { useBackButton } from '@react-navigation/native';
// import { RouteProp } from '@react-navigation/native';
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

function CurrencySelection({}: CurrencySelectionProps) {
  const [selectedCurrency, setSelectedCurrency] = useState<Currency>(currencies[0]);

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Display Currency</Text>
      <Text style={styles.subtitle}>
        Select your preferred display currency. This will be used to show fiat values for your crypto holdings.
      </Text>
      
      <FlatList
        data={currencies}
        keyExtractor={(item) => item.code}
        renderItem={({ item }) => (
          <TouchableOpacity 
            style={[
              styles.currencyItem,
              { backgroundColor: item.code === selectedCurrency.code ? '#f0f4ff' : '#fff' }
            ]}
            onPress={() => setSelectedCurrency(item)}
          >
            <Text style={styles.currencySymbol}>{item.symbol}</Text>
            <Text style={styles.currencyName}>{item.name} ({item.code})</Text>
          </TouchableOpacity>
        )}
      />
      
      <TouchableOpacity 
        style={styles.confirmButton}
        onPress={() => {
          //todoo
          navigation.navigate('App', { currency: selectedCurrency });
        }}
      >
        <Text style={styles.confirmButtonText}>Confirm</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 24,
    backgroundColor: '#fff',
  },
  time: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 24,
    alignSelf: 'center',
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
    paddingHorizontal: 24,
    borderRadius: 8,
    marginVertical: 8,
  },
  currencySymbol: {
    fontSize: 20,
    color: '#007bff',
    marginRight: 8,
  },
  currencyName: {
    fontSize: 16,
    fontWeight: '500',
  },
  confirmButton: {
    backgroundColor: '#007bff',
    paddingVertical: 12,
    paddingHorizontal: 24,
    borderRadius: 8,
    marginTop: 32,
  },
  confirmButtonText: {
    color: '#fff',
    fontSize: 18,
    fontWeight: 'bold',
  },
});

export default CurrencySelection;