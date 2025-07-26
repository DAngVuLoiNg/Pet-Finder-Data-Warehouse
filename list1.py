key = {'a': 'n', 'b': 'o', 'c': 'p', 'd': 'q', 'e': 'r', 'f': 's', 'g': 't', 'h': 'u', 'i': 'v', 'j': 'w', 'k': 'x', 'l': 'y',
'm': 'z', 'n': 'a', 'o': 'b', 'p': 'c', 'q': 'd', 'r': 'e', 's': 'f', 't': 'g', 'u': 'h', 'v': 'i', 'w': 'j', 'x': 'k',
'y': 'l', 'z': 'm','0': '5', '1': '6', '2': '7', '3': '8', '4': '9', '5': '0', '6': '1', '7': '2', '8': '3', '9': '4'}

def rot_18(var1 : str) -> str:
    result = ""

    for i in var1:
        if i.isupper() and i.lower() in key:
                result += key[i.lower()].upper()
        elif i in key:
            result += key[i]
        else:
            result += i

    
    return result

def forking_test:
    pass

sentence = input("Please enter a sentence needed to be encode / decode by ROT-18: ")

if len(sentence) == 0 or sentence.isspace() or not sentence.isprintable():
    print("You didn't enter a sentence!")
    quit()


print(f"Your sentence after transformed by ROT-18 is: {rot_18(sentence)}")
