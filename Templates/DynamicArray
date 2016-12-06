#ifndef DYNAMICARRAY_H
#define DYNAMICARRAY_H

/*!
 *\brief Dynamic Array Class Template
 *\class
 */
template<class T>
class DynamArray{
public:
    /*!
     * \brief DynamArray - Default Constructor
     */
    DynamArray();
    /*!
     * \brief DynamArray - Copy Constructor
     * \param d - Array to be copied
     */
    DynamArray(const DynamArray &d);
    ~DynamArray();
    /*!
     * \brief operator = - Overloading operator
     * \param d - Array to be copied too
     * \return - Newly copied array
     */
    DynamArray& operator=(const DynamArray &d);
    /*!
     * \brief operator [] - Overloading Operator
     * \param index - Access Index
     * \return - Item of that index
     */
    T& operator[](int index);
    /*!
     * \brief Add - Adds item to the array
     * \param item - Item to be added
     */
    void Add(const T &item);
    /*!
     * \brief GetSize
     * \return Size of the array
     */
    int GetSize();
    /*!
     * \brief SetSize
     * \param newSize
     */
    void SetSize(int newSize);
    /*!
     * \brief Clear - Clears the array
     */
    void Clear();
    /*!
     * \brief Delete - Removes item from array
     * \param index - Index of item to be removed
     */
    void Delete(int index);
    /*!
     * \brief GetPtr
     * \return Address of dynamic memory
     */
    void* GetPtr();
private:
    /*!
     * \brief array - Pointer to array
     */
    T *array;
    /*!
     * \brief size - Size of the array
     */
    int size;
    /*!
     * \brief realSize - Size of the array in memory
     */
    int realSize;
    /*!
     * \brief arrayStep - Max size of memory block
     */
    const static int arrayStep = 128;
    /*!
     * \brief arrayMulti - Constant multiplier if array hits max size
     */
    const static int arrayMulti = 2;
};

//Default Constructor
template<class T>
DynamArray<T>::DynamArray(){
    //Determines the memory size of T
    realSize = arrayStep;
    size = 0;
    //Create new dynamic array with one elemenet
    array = new T[realSize * sizeof(T)];
}

//Destructor
template<class T>
DynamArray<T>::~DynamArray(){
    //Delete dynamic memory
    if(array){
        delete [] array;
        //Sets pointer variable to NULL
        array = NULL;
    }
}

//Copy Constructor
template<class T>
DynamArray<T>::DynamArray(const DynamArray &d){
    //Creates memory space for new array based on passed array
    array = new T[sizeof(T) * d.realSize];

    //Copies over elements
    for(int i = 0; i < d.size; ++i){
        array[i] = d.array[i];
    }

    //Sets size of array
    size = d.size;
    realSize = d.realSize;
}

//Overload assignmnent operator
//Provides deep copy
template<class T>
DynamArray<T>& DynamArray<T>::operator =(const DynamArray &d){
    if(this == &d)
        return *this;

    //Clears array if passed parameter is cleared
    if(d.size == 0)
        Clear();

    //Resets the size of the recieving
    SetSize(d.size);

    //Copies over elements
    for(int i = 0; i < d.size; ++i){
        array[i] = d.array[i];
    }

    return *this;
}

//Sets size of the array
template<class T>
void DynamArray<T>::SetSize(int newSize){
    //Used passed parameter
    size = newSize;

    //Calculates size of memory space by using #elements
    // and the memory size of T
    if(size != 0){
        if((size > realSize) || (size < realSize/2)){
            realSize = size;
            array = new T[sizeof(T) * size];
        }
    }else{
        //Clears array of no elements
        Clear();
    }
}

//Clears the array
template<class T>
void DynamArray<T>::Clear(){
    //Delete exisiting array
    delete [] array;
    //Determines the memory size of T
    realSize = arrayStep;
    size = 0;
    //Reassign new dynamic array with one elemenet
    array = new T[realSize * sizeof(T)];
}

//Deletes specific index
template<class T>
void DynamArray<T>::Delete(int index){
    //Clears the array if there is only one element
    if(size == 1){
        Clear();
    }else{
        //deletes the passed index
        for(int i = index; i < size - 1; ++i){
            array[i] = array[i + 1];
        }
        //Decreases size
        size--;
    }
}

//Gets the pointer to the array in the stack
template<class T>
void* DynamArray<T>::GetPtr(){
    return array;
}

//Overloads the [] operator
template<class T>
T& DynamArray<T>::operator [](int index){
    //Returns the value at the passed index
    return array[index];
}

//Adds an element to the array
template<class T>
void DynamArray<T>::Add(const T &item){
    //Increases #element of the array
    T* temp = nullptr;
    size++;

    //if size is greater than max capacity
    //Multiples the max capacity by 2
    if(size > realSize){
        realSize *= arrayMulti;
        //Creates a new array with the new size
        temp = new T[size];
        //Copies items from previous array into new array
        for(int i = 0; i < size; i++){
            temp[i] = array[i];
        }
        //Assigns new array to the class pointer variable
        array = temp;
    }
    //Adds the new item to the end of the resized array
    array[size -1] = item;
    //Deletes the temporary array
    delete temp;
}

//Returns #elements
template<class T>
int DynamArray<T>::GetSize(){
    return size;
}

#endif // DYNAMICARRAY_H
