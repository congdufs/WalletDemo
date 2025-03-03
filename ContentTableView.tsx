import React from 'react';
import {
  SectionList,
  TouchableOpacity,
  View,
  Text,
  StyleSheet,
  SectionListData,
  ListRenderItemInfo
} from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';

// 1. 定义类型
type ListItem = {
  id: string;
  title: string;
};

type Section = {
  title: string;
  data: ListItem[];
};

type RootStackParamList = {
  GroupedTable: undefined;
  Detail: { itemId: string };
};

type GroupedTableViewScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'GroupedTable'
>;

type GroupedTableViewScreenRouteProp = RouteProp<RootStackParamList, 'GroupedTable'>;

type Props = {
  navigation: GroupedTableViewScreenNavigationProp;
  route: GroupedTableViewScreenRouteProp;
};

// 2. 类型化数据源
const sections: Section[] = [
  {
    title: '第一组',
    data: [
      { id: '1', title: '选项 1' },
      { id: '2', title: '选项 2' },
      { id: '3', title: '选项 3' },
    ],
  },
  // ...其他分组
];

// 3. 强类型组件
const GroupedTableViewScreen: React.FC<Props> = ({ navigation }) => {
  const renderSectionHeader = ({
    section,
  }: {
    section: SectionListData<ListItem>;
  }) => (
    <View style={styles.sectionHeader}>
      <Text style={styles.sectionHeaderText}>{section.title}</Text>
    </View>
  );

  const renderItem = ({ item }: ListRenderItemInfo<ListItem>) => (
    <TouchableOpacity
      style={styles.cell}
      onPress={() => navigation.navigate('Detail', { itemId: item.id })}
      activeOpacity={0.8}
    >
      <Text style={styles.cellText}>{item.title}</Text>
      <View style={styles.accessory}>
        <Text style={styles.accessoryText}>〉</Text>
      </View>
    </TouchableOpacity>
  );

  return (
    <SectionList
      sections={sections}
      keyExtractor={(item) => item.id}
      renderItem={renderItem}
      renderSectionHeader={renderSectionHeader}
      ItemSeparatorComponent={() => <View style={styles.separator} />}
      style={styles.container}
      contentContainerStyle={styles.contentContainer}
    />
  );
};

// 样式保持与之前相同...
export default GroupedTableViewScreen;