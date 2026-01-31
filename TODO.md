

TODOs:

remove todo from tracked files.

change Native Language to App Language. Also all languages in this dropdown should look in their own language, regardless of app language. add small flags per dropdown list item.

Let's check the UX inside @lib/features/onboarding/presentation/pages/language_selection_screen.dart . Few of my concerns:
1. I'm not sure to about the native language title. So this language is going to be used as the primary language in the app both for UI and conversations throughout the language learning journey of the user. What are some alternative that I can call to this title. You can also suggest about the tip below the language selection dropdown. I am thinking of the title Main Language. Think about it.
2- Pick your languages title. This page is the first page that user sees, so this title could be more welcoming and generic.
3- other languages title. Let's remove it all together with all the text, translations and tests. Also let's add a todo to the @lib/features/onboarding/presentation/pages/onboarding_conversation_screen.dart  to implement to get this info from user through conversation (and his/her level in the specific language)
4- I want to learn title. I want this to be subject-neutral. So no "I" in the title. I want this to sound natural in other languages, so come up with some suggestions for this as well.
When we implement the change, make sure you update all the translations, variables

Update "Native Language" section to look like a dropdown/input. make it with flags. these languages should be seen in their native languages, and should not be changed per selection. explain this better to AI.
tests should run on gh pipeline. https://gemini.google.com/share/1cf35b5ad5f6
fix warning while running flutter run.

Issues:

Warning: Pub installs executables into C:\Users\atil\AppData\Local\Pub\Cache\bin, which is not on your path.
You can fix that by adding that directory to your system's "Path" environment variable.
A web search for "configure windows path" will show you how.

D/FlutterJNI(31175): flutter (null) was loaded normally! why null?

Error connecting to the service protocol: failed to connect to http://127.0.0.1:53534/bvYOGDFU_4g=/ HttpException: Connection closed before full header was received, uri =
http://127.0.0.1:53534/bvYOGDFU_4g=/ws

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
    - get other languages too.

ui design main page

ui design chat page

ui design settings page

ui design profile page
- incl. user data and settings, during onboarding

ui design curriculum page

install
- Windsurf
- vs code with gh co-pilot

add flutter instructions to all: https://docs.flutter.dev/ai/ai-rules


Future improvements:
- use GenUI SDK for Flutter packages in chats in the glotist app: https://docs.flutter.dev/ai/genui, https://youtu.be/K2p5Nrn2OSU?si=Ejg_rofqfNtWjiLf
- Yapay Zeka Ajanları nasil konusacak mimarisi: https://gemini.google.com/share/d004dcd1ba3d
- telaffuz mimarisi canlı iki katmanlı: https://gemini.google.com/app/6783dbd2cd02bbc9
- sarkiyla ogrenme, karaoke. Replikle ogrenme de dusun.