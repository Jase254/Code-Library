class Node(object):
    def __init__(self, data, prev_n, next_n):
        self.data = data
        self.prev_n = prev_n
        self.next_n = next_n


class DoubleLinkedList(object):
    head = None
    tail = None

    def append(self, data):
        new_node = Node(data, None, None)
        if self.head is None:
            self.head = self.tail = new_node;
        else:
            new_node.prev = self.tail
            new_node.next_n = None
            self.tail.next_n = new_node
            self.tail = new_node

    def remove(self, node_value):
        current_node = self.head

        while current_node is not None:
            if current_node.data == node_value:
                if current_node.prev_n is not None:
                    current_node.prev.next_n = current_node.next_n
                    current_node.text.prev_n = current_node.prev_n
                else:
                    self.head = current_node.next_n
                    current_node.next_n.prev_n = None

            current_node = current_node.next_n

    def show(self):
        print("Current List: ")
        current_node = self.head
        while current_node is not None:
            print(current_node.data if hasattr(current_node, "data") else None)

            current_node = current_node.next_n
        print("*" * 50)


d = DoubleLinkedList()

d.append(5)
d.append(10)
d.append(15)
d.append(30)

d.show()
