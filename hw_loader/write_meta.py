with open('meta.bin', 'wb') as file:
    file.write(b'\x10')
    file.write(b'\x00' * 7)
    file.write(b'\x00' * 24)
    with open('text.bin', 'rb') as input_file:
        file.write(input_file.read())
