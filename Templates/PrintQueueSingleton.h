#ifndef EXTRACREDITLIST_PRINTQUEUESINGLETON_H
#define EXTRACREDITLIST_PRINTQUEUESINGLETON_H

#include <iostream>
#include <string>

using namespace std;

//Definition of the node
template <class T>
struct  node {
    T info;
    node<T>  *next;
    node<T>  *back;
};

template <class T>
class PrintQueueSingleton {
public:
    bool  isEmptyList();
    //Function returns true if the list is empty;
    //otherwise, it returns false
    void print();
    //Output the info contained in each node
    int AddJob(const T &newItem);
    //newItem at the end of the list
    //Post: first points to the new list and the
    //   newItem is inserted at the proper place in the list
    void CancelJob(int nJobNumber = 0);
    //If found, the node containing the CancelJob is deleted
    //from the list
    //Post: first points to the first node of the
    //   new list
    static PrintQueueSingleton* getInstance();
    ~PrintQueueSingleton();
    //Destructor
    //Post: list object is destroyed
    class InvalidRequest{ //Exception class
    public:
        //Exception class constructor
        InvalidRequest(){
          jobNumber = 0;
        };
        InvalidRequest(int JobNum){
          jobNumber = JobNum;
        };
        int GetJobNumber(){
          return jobNumber;
        }
    private:
        int jobNumber;
    };
private:
    //Private constructor
    PrintQueueSingleton();
    //Default constructor
    //Initialize list to an empty state
    //Post: first = NULL
    node<T> *head;  //pointer to the list
    int size; // # of nodes in the list
    static bool instanceFlag; //If queue has been instantiated before
    //Pointer to Queue object
    static PrintQueueSingleton *Queue;
};

template <class T>
bool PrintQueueSingleton<T>::instanceFlag = false;

template <class T>
PrintQueueSingleton<T>* PrintQueueSingleton<T>::Queue = NULL;

//Default constructor
template<class T>
PrintQueueSingleton<T>::PrintQueueSingleton() {
  head= NULL;
  size = 0;
}

template<class T>
void PrintQueueSingleton<T>::print() {
  node<T> *iptr; //pointer to traverse the list
  int num = 1;

  iptr = head;  //set iptr to point to the first node

  if(iptr == NULL){
    throw InvalidRequest();
  }else {
    while (iptr != NULL) {
      cout << "Job Number " << num << ": " << iptr->info << "\n";  //output info
      iptr = iptr->next;
      ++num;
    }//end while
  }
}//end printList

//Check if the list is empty
template<class T>
bool PrintQueueSingleton<T>::isEmptyList() {
  return (head == NULL);
}

template<class T>
int PrintQueueSingleton<T>::AddJob(const T &newItem) {
  node<T> *iptr; // pointer just before loop
  node<T> *newNode;  // pointer to create a node
  bool found;

  newNode = new node<T>; //create the node
  newNode->info = newItem;  //store new item in the node
  newNode->next = NULL;
  newNode->back = NULL;

  cout << "Adding: " << newNode->info << endl;

  if(head == NULL) { //if list is empty, newNode is the only node
    head = newNode;
    ++size;
    return size;
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
    return size;
  }
}//end addNode

template<class T>
void PrintQueueSingleton<T>::CancelJob(int nJobNumber) {
  node<T> *loop; // pointer to traverse the list
  node<T> *iptr; // pointer just before loop

  if(isEmptyList()){
    throw InvalidRequest();
  }else if((nJobNumber > size) || (nJobNumber < 0)){
    throw InvalidRequest(nJobNumber);
  }else if (nJobNumber == 0)    // node to be deleted is the first node
    {
      loop = head;
      head = head->next;

      if (head != NULL)
        head->back = NULL;

      delete loop;
      --size;
    } else {
    //Loops until selected job is found
      loop = NULL;
      iptr = head;

      for (int i = 1; i < nJobNumber; ++i) {
        iptr = iptr->next;
      }

    //Restructures nodes
      loop = iptr->back;
      loop->next = iptr->next;
      delete iptr;
      --size;
    }//end else
}



//Destructor
template<class T>
PrintQueueSingleton<T>::~PrintQueueSingleton() {
  node<T> *iptr, *loop; //pointer to traverse the list

  iptr = head;

  while(iptr != NULL) {
    loop = iptr;
    iptr = iptr->next;
    delete loop;
    --size;
  }

  instanceFlag = false;
}

//Checks if Queue has been created
template <class T>
PrintQueueSingleton<T> *PrintQueueSingleton<T>::getInstance() {
  if(! instanceFlag){
    Queue = new PrintQueueSingleton();
    instanceFlag = true;
    return Queue;
  }else{
    return Queue;
  }
}


#endif //EXTRACREDITLIST_PRINTQUEUESINGLETON_H
