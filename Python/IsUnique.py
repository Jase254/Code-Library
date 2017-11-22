class UniqueTester:
	def __init__(self, string):
		self.size = len(string)
		self.arr = [None] * self.size
		self.string = string
		self.create_table()

	def hasher(self, key, it = 0):
		if it >= len(self.arr):
			return -1 
		result  = (self.first_hash(key) + it * (self.second_hash(key))) % self.size
		print('result:', result)
		if self.arr[result] is None:
			return result
		elif ord(self.arr[result]) == key:
			return -1
		else: 
			return self.hasher(key, it+1)

	def create_table(self):
		current_index = 0
		unique = True
		for x in range (0, len(self.string)):
			current_index = self.hasher(ord(self.string[x])) 
			if current_index == -1:
				unique = False
			else:
				self.arr[current_index] = self.string[x]
		print(self.arr)
		if unique == False:
			print('Your shit is the same!')
		else:
			print('Unique Shit!')

	def first_hash(self, key):
		return key % self.size
	
	def second_hash(self, key):
		return (2 * key + 1) 
		 
		

def main():
	unique_test = UniqueTester('abcdefghijk')

main()	 
