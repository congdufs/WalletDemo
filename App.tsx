import React, { useEffect, useState }  from 'react';
import {
  SafeAreaView,
  FlatList,
  Text,
  TouchableOpacity,
  StyleSheet,
  Image,
  View,
} from 'react-native';
import { useNavigation, useFocusEffect, useRoute } from '@react-navigation/native';
import type { AppScreenProps } from './navigation';


// mock data
const mockData = [
  {
    title: 'Account',
    items: [
      {
        mainText: 'Display Currency',
        subText: '$USD',
      },
      {
        mainText: 'Language',
        subText: 'English',
      },
      {
        mainText: 'Appearance',
        subText: 'Light',
      },
      {
        mainText: 'Notifications',
        subText: '',
      }
    ]
  },
  {
    title: 'Support',
    items: [
      {
        mainText: 'Help Center',
        subText: '',
      },
      {
        mainText: 'New to DeFi',
        subText: '',
      },
      {
        mainText: 'Join Community',
        subText: '',
      },
      {
        mainText: 'Give Feedback',
        subText: '',
      }
    ]
  }
];

interface AppProps {}

function App({}: AppProps) {
  const navigation = useNavigation<AppScreenProps['navigation']>();
  const route = useRoute();
  // const [displayCurrency, setDisplayCurrency] = useState<string | null>('$USD');
  const [displayCurrency, setDisplayCurrency] = useState<Currency | null>({
    symbol: '$',
    name: 'US Dollar',
    code: 'USD',
  });
  
  

  useFocusEffect(() => {
    const receivedData = route.params?.currency;
    if (receivedData) {
      setDisplayCurrency(receivedData);
    }
  });

  return (
    <SafeAreaView style={styles.container}>
      <FlatList
        data={mockData}
        keyExtractor={(item) => item.title}
        renderItem={({ item }) => (
          <>
            <TouchableOpacity style={styles.header} onPress={() => alert(item.title)}>
              <Text style={styles.headerText}>{item.title}</Text>
            </TouchableOpacity>
            {item.items.map((content, index) => {
              const firstItem = index === 0;
              const lastItem = index === item.items.length - 1;

              let borderRadiusStyle = {};
              if (firstItem) {
                borderRadiusStyle = { borderTopLeftRadius: 8, borderTopRightRadius: 8 };
              } else if (lastItem) {
                borderRadiusStyle = { borderBottomLeftRadius: 8, borderBottomRightRadius: 8 };
              }

              return (
                <React.Fragment key={index}>
                  <TouchableOpacity
                    style={[styles.item, borderRadiusStyle]}
                    onPress={() => {
                      switch (content.mainText) {
                        case 'Display Currency':
                          navigation.navigate('CurrencySelection', { 
                            currentCurrency: displayCurrency,
                          });
                          break;
                        default:
                          alert(content.mainText);
                      }
                    }}
                  >
                    <Text style={styles.mainText}>{content.mainText}</Text>
                    {/* {content.subText ? (
                      <Text style={styles.subText}>{content.subText}</Text>
                    ) : null} */}
                    {content.mainText === 'Display Currency' ? (
                      <Text style={styles.subText}>{displayCurrency.symbol+displayCurrency.code}</Text>
                    ) : content.subText ? (
                      <Text style={styles.subText}>{content.subText}</Text>
                    ) : null}
                    <Image 
                      source={require('./assets/images/arrow.png')} 
                      style={styles.iconImage} 
                    />
                  </TouchableOpacity>
                  {!lastItem && <View style={styles.separator} />}
                </React.Fragment>
              );
            })}
          </>
        )}
        contentContainerStyle={styles.contentContainer}
      />
    </SafeAreaView>
  );
}
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#ffffff',
    paddingTop: 0,
  },
  
  contentContainer: {
    paddingTop: 0,
  },
  
  header: {
    backgroundColor: '#ffffff',
    paddingVertical: 8,
    paddingHorizontal: 24,
    borderRadius: 8,
    marginBottom: 8,
  },
  
  headerText: {
    fontSize: 12,
    color: '#333333',
  },
  
  item: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 10,
    marginHorizontal: 24,
    marginVertical: 0,
    backgroundColor: '#f0f9fa',
  },

  mainText: {
    flex: 1,
    paddingHorizontal: 16,
    fontSize: 14,
    color: '#333333',
  },
    
  subText: {
    fontSize: 12,
    color: '#000000',
    textAlign: 'right',
    marginLeft: 5,
  },

  iconImage: {
    width: 20,
    height: 20,
    resizeMode: 'contain',
    marginLeft: 'auto', 
    marginRight: 12,
  },

  separator: {
    height: 1,
    backgroundColor: '#cccccc',
    marginHorizontal: 24,
  },
});

export default App;