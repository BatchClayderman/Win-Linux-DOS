lists = []
for i in range(2, 1000):
	for j in range(2, int(i ** 0.5) + 1):
		if i % j == 0:
			break
	else:
		lists.append(i)
print(lists)