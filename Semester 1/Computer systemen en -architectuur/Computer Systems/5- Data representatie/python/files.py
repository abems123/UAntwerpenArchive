ASCII = "ascii"
UTF_8 = "utf-8"
UTF_16 = "utf-16"

def read_file(filename, en="utf-8"):
    output = ""
    with open(filename, encoding=en) as fin:
        for line in fin:
            output += line
    return output

def write_file(filename, contents, en="utf-8"):
    with open(filename, "w", encoding=en) as fout:
        fout.write(contents)

def write_html_file(filename, content):
    with open(filename, "w") as fout:
        fout.write("<html>")
        fout.write(content)
        fout.write("</html>")
