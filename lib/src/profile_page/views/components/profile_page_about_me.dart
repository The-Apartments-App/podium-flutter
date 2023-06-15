import 'package:flutter/material.dart';
import 'package:podium/src/profile_page/views/components/profile_page_about_me_info_item.dart';

class ProfilePageAboutMe extends StatefulWidget {
  const ProfilePageAboutMe({
    super.key,
    required this.userBirthday,
    required this.userWork,
    required this.favoriteSong,
    required this.funFact,
    required this.spendTime,
    required this.school,
    required this.uselessSkill,
    required this.obsession,
    required this.biographyTitle,
    required this.language,
    required this.residence,
  });

  final String userBirthday;
  final String userWork;
  final String favoriteSong;
  final String funFact;
  final String spendTime;
  final String school;
  final String uselessSkill;
  final String obsession;
  final String biographyTitle;
  final String language;
  final String residence;

  @override
  ProfilePageAboutMeState createState() => ProfilePageAboutMeState();
}

class ProfilePageAboutMeState extends State<ProfilePageAboutMe> {
  ProfilePageAboutMeState();
  late String userBirthday;
  late String userWork;
  late String favoriteSong;
  late String funFact;
  late String spendTime;
  late String school;
  late String uselessSkill;
  late String obsession;
  late String biographyTitle;
  late String language;
  late String residence;

  @override
  void initState() {
    super.initState();

    userBirthday = widget.userBirthday;
    userWork = widget.userWork;
    favoriteSong = widget.favoriteSong;
    funFact = widget.funFact;
    spendTime = widget.spendTime;
    school = widget.school;
    uselessSkill = widget.uselessSkill;
    obsession = widget.obsession;
    biographyTitle = widget.biographyTitle;
    language = widget.language;
    residence = widget.residence; // Add the rest of your fields here...
  }

  Future<void> _updateField(
    BuildContext context,
    String fieldName,
    String currentValue,
    String modalHeadline,
    String modalSubtext,
  ) async {
    final controller = TextEditingController(text: currentValue);

    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    if (isLargeScreen) {
      // For large screens, show a dialog
      return showDialog<void>(
        context: context, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            content: SizedBox(
              width: 500,
              height: 225,
              child: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const Row(
                      children: [
                        CloseButton(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            modalHeadline,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            modalSubtext,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: .95,
                      child: TextFormField(
                        controller: controller,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF03795D),
                            ),
                          ),
                          labelText: fieldName,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF03795D), // background color
                      foregroundColor: Colors.white, // text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      _updateValue(fieldName, controller.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      );
    } else {
      // For smaller screens, show a modal bottom sheet
      await showModalBottomSheet<void>(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                const Row(
                  children: [
                    CloseButton(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        modalHeadline,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        modalSubtext,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  controller: controller,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFF03795D),
                      ),
                    ),
                    labelText: fieldName,
                  ),
                ),
                SizedBox(
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF03795D), // background color
                      foregroundColor: Colors.white, // text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      _updateValue(fieldName, controller.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
    }
  }

  void _updateValue(String fieldName, String newValue) {
    setState(() {
      switch (fieldName) {
        case 'Born in the':
          userBirthday = newValue;
          break;
        case 'My work':
          userWork = newValue;
          break;
        case 'My favorite song':
          favoriteSong = newValue;
          break;
        case 'A fun fact about me':
          funFact = newValue;
          break;
        case 'In my spare time':
          spendTime = newValue;
          break;
        case 'Where I went to school':
          school = newValue;
          break;
        case 'A useless skill I have':
          uselessSkill = newValue;
          break;
        case 'My biggest obsession':
          obsession = newValue;
          break;
        case 'My biography would be titled':
          biographyTitle = newValue;
          break;
        case 'My first language':
          language = newValue;
          break;
        case 'Where I reside':
          residence = newValue;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        ProfilePageAboutMeInfoItem(
          fieldName: 'Born in the',
          fieldValue: userBirthday,
          icon: Icons.cake,
          onTap: _updateField,
          modalHeadline:
              'Travel back in time, when was your first hello to the world?',
          modalSubtext: 'Tell us about your roots and early beginnings.',
        ),
        ProfilePageAboutMeInfoItem(
          fieldName: 'My work',
          fieldValue: userWork,
          icon: Icons.work,
          onTap: _updateField,
          modalHeadline: 'What adventure pays your bills?',
          modalSubtext: 'Every job is a journey. Share yours.',
        ),
        ProfilePageAboutMeInfoItem(
          fieldName: 'My favorite song',
          fieldValue: favoriteSong,
          icon: Icons.music_note,
          onTap: _updateField,
          modalHeadline: 'What tune makes your heart dance?',
          modalSubtext: "Music speaks when words can't. What's your anthem?",
        ),
        ProfilePageAboutMeInfoItem(
          fieldName: 'A fun fact about me',
          fieldValue: funFact,
          icon: Icons.emoji_emotions_outlined,
          onTap: _updateField,
          modalHeadline: 'Got a fun secret? We promise not to tell!',
          modalSubtext: "Everyone has a quirky side. Let's hear about yours.",
        ),
        ProfilePageAboutMeInfoItem(
          fieldName: 'In my spare time',
          fieldValue: spendTime,
          icon: Icons.access_time,
          onTap: _updateField,
          modalHeadline: 'How do you spend time in your own wonderland?',
          modalSubtext:
              'Hobbies, interests, or just a lazy day - how do you unwind?',
        ),
        ProfilePageAboutMeInfoItem(
          fieldName: 'Where I went to school',
          fieldValue: school,
          icon: Icons.school,
          onTap: _updateField,
          modalHeadline: 'Where did you gather your wisdom?',
          modalSubtext: 'Education is a journey. Where did yours take place?',
        ),
        ProfilePageAboutMeInfoItem(
          fieldName: 'A useless skill I have',
          fieldValue: uselessSkill,
          icon: Icons.auto_awesome,
          onTap: _updateField,
          modalHeadline:
              "What's your superpower... that the world isn't ready for yet?",
          modalSubtext: 'Even the most peculiar skills can be fun to share!',
        ),
        ProfilePageAboutMeInfoItem(
          fieldName: 'My biggest obsession',
          fieldValue: obsession,
          icon: Icons.favorite,
          onTap: _updateField,
          modalHeadline: "What can't you get enough of?",
          modalSubtext:
              'Passions and obsessions make us unique. What is yours?',
        ),
        ProfilePageAboutMeInfoItem(
          fieldName: 'My biography would be titled',
          fieldValue: biographyTitle,
          icon: Icons.book,
          onTap: _updateField,
          modalHeadline: 'If your life was a book, what would be the title?',
          modalSubtext:
              'Titles can be intriguing, mysterious, or plain fun. Surprise us!',
        ),
        ProfilePageAboutMeInfoItem(
          fieldName: 'My first language',
          fieldValue: language,
          icon: Icons.language,
          onTap: _updateField,
          modalHeadline: 'What was the first language you whispered?',
          modalSubtext:
              'Language shapes our worldview. Which one shaped yours?',
        ),
        ProfilePageAboutMeInfoItem(
          fieldName: 'Where I reside',
          fieldValue: residence,
          icon: Icons.home,
          onTap: _updateField,
          modalHeadline: 'Where is your heart anchored?',
          modalSubtext: "Every place has a story. What's yours?",
        ),
      ],
    );
  }
}
