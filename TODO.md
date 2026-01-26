
install
- Windsurf
- Cursor
- vs code with gh co-pilot
- integrate claude code: https://gemini.google.com/share/1c97b6d8fb8a

add flutter instructions to all: https://docs.flutter.dev/ai/ai-rules

change Native Language to App Language. Also all languages in this dropdown should look in their own language, regardless of app language. add small flags per dropdown list item.
instead of "other languages", use title "languages I know/can speak". add a disclaimer "these language are used to enhance your learning experience with some tips and resemblances".

Update "Native Language" section to look like a dropdown/input. make it with flags. app lang changes dynamically based on this selection.
tests should run on gh pipeline. https://gemini.google.com/share/1cf35b5ad5f6
fix warning while running flutter run.

Warning: Pub installs executables into C:\Users\atil\AppData\Local\Pub\Cache\bin, which is not on your path.
You can fix that by adding that directory to your system's "Path" environment variable.
A web search for "configure windows path" will show you how.


PS D:\atili\Glotist\glotist_app> arb_translate
arb_translate : The term 'arb_translate' is not recognized as the name of a 
cmdlet, function, script file, or operable program. Check the spelling of    
At line:1 char:1
+ arb_translate
+ ~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (arb_translate:String) [], Co  
   mmandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException

PS D:\atili\Glotist\glotist_app> cd 'd:\atili\Glotist\glotist_app'
PS D:\atili\Glotist\glotist_app> dart pub global run arb_translate
Translating 19 terms for locale de...


https://gemini.google.com/share/5cdab3f563a2
PS D:\atili\Glotist\glotist_app> dart pub global run arb_translate
Expected "arb-translate-model" to be equal to one of (gemini-1.0-pro, gemini-1.5-pro, gemini-1.5-flash, gpt-3.5-turbo, gpt-4, gpt-4-turbo, gpt-4o), instead was "gemini-1.5-flash-001"


review code



ui design onboarding discussion/chat
- skip to manual selection available during discussion. or both can be done in the same ui
- for onboarding conversation, user can speak/write in their own language, glotist will translate and try to teach the translation during discussion.
- onboarding topics: basic info, learning goals, current levels, interests.
    - after info collection is done, give user an engaging story about the relationship between target and native languages.

ui design main page

ui design chat page

ui design settings page

ui design profile page
- incl. user data and settings, during onboarding

ui design curriculum page

Future improvements:
- use GenUI SDK for Flutter packages in chats in the glotist app: https://docs.flutter.dev/ai/genui, https://youtu.be/K2p5Nrn2OSU?si=Ejg_rofqfNtWjiLf
- Yapay Zeka Ajanları nasil konusacak mimarisi: https://gemini.google.com/share/d004dcd1ba3d
- telaffuz mimarisi canlı iki katmanlı: https://gemini.google.com/app/6783dbd2cd02bbc9