

import 'package:covid19_tracker/models/CovidQnA.dart';

class CovidQueries {
  CovidQueries._(); // un-instantiable
  static final List<CovidQnA> queries = <CovidQnA>[
    CovidQnA(question: 'What is the incubation period of COVID-19?',
              answer: 'The median incubation period is 5.1 days (range 1–14 days)'
                  '. The precise interval during which an individual with '
                  'COVID-19 is infectious is uncertain. As per the current'
                  ' evidence, the period of infectivity starts 2 days prior to'
                  ' onset of symptoms and declines rapidly within the first week'
                  ' of symptom onset.'),
    CovidQnA(question: 'What are some of the most common symptoms of the coronavirus disease?',
            answer: 'The most common symptoms of COVID-19 are fever, dry cough, and tiredness. Other symptoms that are less common and may affect some patients include loss of taste or smell, aches and pains, headache, sore throat, nasal congestion, red eyes, diarrhoea, or a skin rash.'),
    CovidQnA(question: 'How long can immunity last after a COVID-19 infection?',
            answer: "Initially, scientists observed people's antibody levels rapidly decreased shortly after recovery from COVID-19. However, more recently, we've seen positive signs of long-lasting immunity, with antibody-producing cells in the bone marrow identified seven to eight months following infection with COVID-19."),
    CovidQnA(question: 'Which organs are most affected by COVID-19?',
            answer: "The lungs are the organs most affected by COVID-19 because the virus accesses host cells via the receptor for the enzyme angiotensin-converting enzyme 2 (ACE2), which is most abundant on the surface of type II alveolar cells of the lungs.")
    // add more here
  ];

}