#ifndef EXTRACREDIT_DLINKEDLIST_H
#define EXTRACREDIT_DLINKEDLIST_H
#include "header.h"

//Definition of the node
template <class T>
struct  node {
    T info;
    node<T>  *next;
    node<T>  *back;
};

template <class T>
class linkedlist {
public:
    void clear();
    //Initialize list to an empty state
    //Post: first = NULL
    bool  isEmptyList();
    //Function returns true if the list is empty;
    //otherwise, it returns false
    void destroy();
    //Delete all nodes from the list
    //Post: first = NULL
    void print();
    //Output the info contained in each node
    int length();
    //Function returns the number of nodes in the list
    void search(const T& searchItem);
    //Outputs "Item is found in the list" if searchItem
    //is in the list; otherwise, outputs "Item not in the list"
    void addNode(const T &newItem);
    //newItem at the end of the list
    //Post: first points to the new list and the
    //   newItem is inserted at the proper place in the list
    void deleteItem(const T &deleteItem);
    //If found, the node containing the deleteItem is deleted
    //from the list
    //Post: first points to the first node of the
    //   new list
    void insertNode(const T &newItem, int index);
    //Loops until index and adds node after index
    void deleteIndex(int index);
    //Deletes a specific index of node
    //Loops through specific # of times
    //Deletes specific node index
    T getNode(int index);
    //Returns item of type T at specific index
    linkedlist();
    //Default constructor
    //Initialize list to an empty state
    //Post: first = NULL
    linkedlist(const linkedlist<T>& otherList);
    //copy constructor
    ~linkedlist();
    //Destructor
    //Post: list object is destroyed

private:
    node<T> *head;  //pointer to the list
    int size; // # of nodes in the list
};

template<class T>
T linkedlist<T>::getNode(int index) {
  node<T> *iptr;

  iptr = head;

  //Traverse list until index
  if(index > size){
    cout << "Index doesnt not exist";
  }else{

    for(int i = 1; i < index; ++i){
      iptr = iptr->next;
    }

    //Output data on stopped node
    return iptr->info;
  }
}

//Default constructor
template<class T>
linkedlist<T>::linkedlist() {
  head= NULL;
  size = 0;
}

//Check if the list is empty
template<class T>
bool linkedlist<T>::isEmptyList() {
  return(head == NULL);
}


template<class T>
void linkedlist<T>::destroy() {
  node<T>  *iptr; //pointer to delete the node

  //Delete every node in the list
  while(head != NULL)
  {
    iptr = head;
    head = head->next;
    delete iptr;
  }
  //Sets size back to zero
  size = 0;
}

//Clear the list
template<class T>
void linkedlist<T>::clear() {
  destroy();
}

//Returns # of nodes in the list
template<class T>
int linkedlist<T>::length() {
  return size;
}


template<class T>
void linkedlist<T>::print() {
  node<T> *iptr; //pointer to traverse the list

  iptr = head;  //set iptr to point to the first node

  if(iptr == NULL){
    cout << "List is empty!" << endl;
  }else {
    while (iptr != NULL) {
      cout << iptr->info << "  ";  //output info
      iptr = iptr->next;
    }//end while
  }
}//end printList


template<class T>
void linkedlist<T>::search(const T& searchItem) {
  bool found;
  node<T> *current; //pointer to traverse the list

  if(head == NULL)
    cout<<"Cannot search an empty list"<<endl;
  else
  {
    found = false;
    current = head;

    while(current != NULL && !found)
      if(current->info >= searchItem)
        found = true;
      else
        current = current->next;

    if(current == NULL)
      cout<<"Item not in the list"<<endl;
    else
    if(current->info == searchItem) //test for equality
      cout<<"Item is found in the list"<<endl;
    else
      cout<<"Item not in the list"<<endl;
  }//end else
}//end search

template<class T>
void linkedlist<T>::addNode(const T &newItem) {
  node<T> *iptr; // pointer just before loop
  node<T> *newNode;  // pointer to create a node
  bool found;

  newNode = new node<T>; //create the node
  newNode->info = newItem;  //store new item in the node
  newNode->next = NULL;
  newNode->back = NULL;

  if(head == NULL) { //if list is empty, newNode is the only node
    head = newNode;
    ++size;
  } //Add newNode to the end of the list
  else {
    iptr = head;

    while (iptr->next != NULL) {
      iptr = iptr->next;
    }

    //Increase size of list
    iptr->next = newNode;
    newNode->back = iptr;
    ++size;
  }
}//end addNode

template<class T>
void linkedlist<T>::deleteItem(const T &deleteItem) {
  node<T> *loop; // pointer to traverse the list
  node<T> *iptr; // pointer just before loop

  bool found;

  if(head == NULL)
    cout<<"Cannot delete from an empty list"<<endl;
  else
  if(head->info == deleteItem)	// node to be deleted is the
    // first node
  {
    loop = head;
    head = head->next;

    if(head != NULL)
      head->back = NULL;

    delete loop;
    --size;
  }
  else
  {
    found = false;
    loop = head;

    while(loop != NULL && !found)  //search the list
      if(loop->info >= deleteItem)
        found = true;
      else
        loop = loop->next;

    if(loop == NULL)
      cout << "Item not found in list" << endl;
    else
    if(loop->info == deleteItem) //check for equality
    {
      iptr = loop->back;
      iptr->next = loop->next;

      if(loop->next != NULL)
        loop->next->back = iptr;

      delete loop;
      --size;
    }
    else
      cout<<"Item to be deleted is not in list."<<endl;
  }//end else
}//end deleteItem


//Destructor
template<class T>
linkedlist<T>::~linkedlist() {
  node<T> *iptr, *loop; //pointer to traverse the list

  iptr = head;

  while(iptr != NULL) {
    loop = iptr;
    iptr = iptr->next;
    delete loop;
    --size;
  }

}

//Deletes specific node number
template<class T>
void linkedlist<T>::deleteIndex(int index) {
  node<T> *iptr, *loop;

  if(head == NULL){
    cout << "List is empty!";
  }else if(index > size){
    cout << "Node doesnt not exist!";
  }else {
    //Traverse until found index
    loop = NULL;
    iptr = head;

    for (int i = 1; i < index; ++i) {
      iptr = iptr->next;
    }

    loop = iptr->back;
    loop->next = iptr->next;
    delete iptr;
    --size;
  }
}

//Insert node at specific index
template<class T>
void linkedlist<T>::insertNode(const T &newItem, int index) {
  node<T> *iptr, *loop, *newNode;

  newNode = new node<T>; //create the node
  newNode->info = newItem;  //store new item in the node
  newNode->next = NULL;
  newNode->back = NULL;

  if(index > size){
    cout << "Index greater than the size of the list!";
  }else if(head == NULL){
    head = newNode;
    ++size;
  }else {
    iptr = head;
    loop = NULL;

    //Traverse until specific index
    for (int i = 1; i < index; ++i) {
      iptr = iptr->next;
    }

    loop = iptr->next;
    iptr->next = newNode;
    newNode->next = loop;
    newNode->back = iptr;
    loop->back = newNode;
    ++size;
  }
}


#endif //EXTRACREDIT_DLINKEDLIST_H
