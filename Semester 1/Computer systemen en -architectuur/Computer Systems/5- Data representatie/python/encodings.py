import files

# (a) Lees het gegeven bestand input.txt in met de correcte encoding (UTF-8 in dit voorbeeld) 
inhoud = files.read_file('input.txt', files.UTF_8) 

# (b) Schrijf de inhoud van de file weg naar een bestand, gebruikmakend van UTF-16 encoding 
files.write_file('text_in_UTF_16.txt', inhoud, files.UTF_16) 

# (c) Zet alle karakters om naar hun overeenkomstige code points. Sla deze op in een bestand genaamd code_points.txt
# ik zet een spatie tussen de code points om niet te mixen
code_points = ' '.join([str(ord(char)) for char in inhoud]) 
files.write_file('code_points.txt', code_points, files.ASCII) 

# (d) Converteer de code points naar hun overeenkomstige HTML code en hou rekening met line breaks 
html_content = '' 
# voor elke character in inhoud
for char in inhoud: 
    # als char een line break is dan
    if char == '\n': 
        # line break in HTML kunnen we krijgen met <br>
        html_content += '<br>' 
    else:
        # om de waard van de code point in html te krijgen, moet het zo geschreven worden
        # &#{CODE_POINT};
        html_content += f'&#{ord(char)};'
files.write_html_file('text_in_HTML.html', html_content)