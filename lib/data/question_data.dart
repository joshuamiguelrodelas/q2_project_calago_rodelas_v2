import '../models/question.dart';

final List<Question> questionPool = [
  Question(
    question: "What is e-waste?",
    options: [
      "Plastic bottles and wrappers",
      "Old or discarded electronic devices",
      "Leftover food waste",
      "Paper and cardboard",
    ],
    correctIndex: 1,
    explanation:
        "E-waste refers only to electronic devices, not food or plastic waste.",
    difficulty: "Easy",
  ),
  Question(
    question: "Which of these is NOT e-waste?",
    options: ["Mobile phone", "Refrigerator", "Banana peel", "Laptop"],
    correctIndex: 2,
    explanation: "Only organic waste like banana peels is not e-waste.",
    difficulty: "Easy",
  ),
  Question(
    question: "Why is proper e-waste disposal important?",
    options: [
      "To save storage space at home",
      "Because electronics contain toxins and valuable metals",
      "To make gadgets last longer",
      "Because it’s illegal to throw away any trash",
    ],
    correctIndex: 1,
    explanation:
        "E-waste disposal matters because of toxic chemicals and recyclable precious metals.",
    difficulty: "Easy",
  ),
  Question(
    question: "Which of these materials can be recovered from e-waste?",
    options: ["Gold", "Sand", "Wood", "Oil"],
    correctIndex: 0,
    explanation:
        "E-waste contains valuable metals like gold, copper, and silver.",
    difficulty: "Medium",
  ),
  Question(
    question: "What is the safest way to deal with an old working phone?",
    options: [
      "Throw it in the trash",
      "Donate or resell it",
      "Burn it to save space",
      "Keep it buried in a drawer forever",
    ],
    correctIndex: 1,
    explanation:
        "Reuse is best—donate or sell working devices before recycling.",
    difficulty: "Easy",
  ),
  Question(
    question: "Which harmful substance is commonly found in e-waste?",
    options: ["Mercury", "Salt", "Vinegar", "Sugar"],
    correctIndex: 0,
    explanation:
        "Electronics often contain mercury, lead, and cadmium, which are toxic.",
    difficulty: "Medium",
  ),
  Question(
    question: "What does the “3R” approach mean?",
    options: [
      "Remove, Replace, Refuse",
      "Reduce, Reuse, Recycle",
      "Repair, Restore, Resell",
      "Return, Refuse, Report",
    ],
    correctIndex: 1,
    explanation:
        "The 3Rs are Reduce, Reuse, Recycle—core steps in managing waste.",
    difficulty: "Easy",
  ),
  Question(
    question: "Which of these is the best way to recycle e-waste?",
    options: [
      "Take it to a certified recycling center",
      "Throw it in regular trash",
      "Leave it on the street",
      "Break it into pieces yourself",
    ],
    correctIndex: 0,
    explanation:
        "Certified centers handle e-waste safely and extract useful materials.",
    difficulty: "Medium",
  ),
  Question(
    question: "What happens if e-waste is dumped in landfills?",
    options: [
      "It makes soil healthier",
      "Toxins can leak into soil and water",
      "It disappears quickly",
      "It becomes fertilizer",
    ],
    correctIndex: 1,
    explanation: "Toxic chemicals in e-waste contaminate soil and water.",
    difficulty: "Medium",
  ),
  Question(
    question: "What can households do to reduce e-waste?",
    options: [
      "Buy fewer, longer-lasting gadgets",
      "Replace gadgets often",
      "Ignore recycling programs",
      "Hoard unused devices",
    ],
    correctIndex: 0,
    explanation:
        "Reducing e-waste starts with mindful purchasing and using devices longer.",
    difficulty: "Easy",
  ),
  Question(
    question: "Which of these organizations often collect e-waste safely?",
    options: [
      "Certified recycling centers",
      "Supermarkets",
      "Clothing shops",
      "Movie theaters",
    ],
    correctIndex: 0,
    explanation:
        "Only certified recycling centers or collection drives handle e-waste responsibly.",
    difficulty: "Medium",
  ),
  Question(
    question: "What should you do before recycling an old laptop or phone?",
    options: [
      "Smash it with a hammer",
      "Remove personal data and batteries",
      "Throw it with household trash",
      "Paint it green",
    ],
    correctIndex: 1,
    explanation:
        "Always clear your data and safely remove batteries before recycling electronics.",
    difficulty: "Medium",
  ),
  Question(
    question: "Which type of e-waste is produced the MOST worldwide?",
    options: [
      "Mobile phones",
      "Small household appliances",
      "Kitchen waste",
      "Books and paper",
    ],
    correctIndex: 1,
    explanation:
        "Small appliances like toasters, irons, and toys make up a huge portion of global e-waste.",
    difficulty: "Hard",
  ),
  Question(
    question:
        "What symbol usually indicates that a device should not be thrown in regular trash?",
    options: [
      "A triangle with arrows (♻️)",
      "A crossed-out trash bin",
      "A green leaf",
      "A battery icon",
    ],
    correctIndex: 1,
    explanation:
        "Electronics often have a crossed-out bin logo, meaning they require special disposal.",
    difficulty: "Medium",
  ),
  Question(
    question: "How can schools help reduce e-waste?",
    options: [
      "By holding e-waste collection drives",
      "By banning electronic devices",
      "By ignoring broken gadgets",
      "By giving every student 10 phones",
    ],
    correctIndex: 0,
    explanation:
        "Schools can educate students and organize collection programs to recycle e-waste properly.",
    difficulty: "Easy",
  ),

  // NEW QUESTIONS TO REACH 100
  Question(
    question: "Which of the following is an example of hazardous e-waste?",
    options: ["Old TV", "Plastic bottle", "Banana peel", "Paper notebook"],
    correctIndex: 0,
    explanation: "Old TVs contain lead and other hazardous materials.",
    difficulty: "Medium",
  ),
  Question(
    question: "Which type of battery is commonly found in mobile phones?",
    options: ["Lithium-ion", "Alkaline", "Zinc-carbon", "Lead-acid"],
    correctIndex: 0,
    explanation: "Most mobile phones use lithium-ion batteries.",
    difficulty: "Easy",
  ),
  Question(
    question: "Which e-waste component can pollute water?",
    options: ["Lead", "Glass screen", "Plastic case", "Screws"],
    correctIndex: 0,
    explanation: "Lead from electronics can seep into soil and water.",
    difficulty: "Medium",
  ),
  Question(
    question: "What does e-waste recycling prevent?",
    options: [
      "Air pollution",
      "Toxic exposure and resource loss",
      "More gadgets",
      "Noise pollution",
    ],
    correctIndex: 1,
    explanation:
        "Recycling reduces toxins in the environment and recovers valuable materials.",
    difficulty: "Medium",
  ),
  Question(
    question: "Which country generates the most e-waste per year?",
    options: ["USA", "India", "Germany", "Brazil"],
    correctIndex: 0,
    explanation: "The USA has the highest per-capita e-waste generation.",
    difficulty: "Hard",
  ),
  Question(
    question: "Which of the following is a rare metal found in e-waste?",
    options: ["Tantalum", "Iron", "Sand", "Water"],
    correctIndex: 0,
    explanation: "Tantalum is used in electronics like capacitors.",
    difficulty: "Hard",
  ),
  Question(
    question: "Which of these is a safe way to dispose of old batteries?",
    options: [
      "Certified collection centers",
      "Throw in trash",
      "Burn them",
      "Dump in river",
    ],
    correctIndex: 0,
    explanation: "Certified collection centers handle batteries safely.",
    difficulty: "Easy",
  ),
  Question(
    question: "What is a common toxin in CRT monitors?",
    options: ["Lead", "Aluminum", "Wood", "Paper"],
    correctIndex: 0,
    explanation: "CRT monitors contain lead in the glass.",
    difficulty: "Medium",
  ),
  Question(
    question: "Why should personal data be removed before recycling devices?",
    options: [
      "To prevent identity theft",
      "To make recycling faster",
      "To reduce size",
      "No need",
    ],
    correctIndex: 0,
    explanation: "Clearing personal data protects privacy.",
    difficulty: "Easy",
  ),
  Question(
    question: "Which of these is a benefit of reusing electronics?",
    options: [
      "Reduces e-waste",
      "Takes more space",
      "Generates pollution",
      "Consumes resources",
    ],
    correctIndex: 0,
    explanation: "Reusing electronics reduces waste and environmental impact.",
    difficulty: "Easy",
  ),
  Question(
    question: "Which of the following devices contains mercury?",
    options: ["Thermostats", "Plastic bottles", "Books", "Shoes"],
    correctIndex: 0,
    explanation:
        "Mercury is found in some electronic devices like thermostats and switches.",
    difficulty: "Medium",
  ),
  Question(
    question: "What is a common consequence of informal e-waste recycling?",
    options: [
      "Soil and water contamination",
      "Better gadget performance",
      "Free electricity",
      "Faster internet",
    ],
    correctIndex: 0,
    explanation:
        "Informal recycling without safety precautions releases toxins into the environment.",
    difficulty: "Medium",
  ),
  Question(
    question: "Which organization often provides e-waste recycling guidelines?",
    options: ["EPA", "Local bakery", "Movie studio", "Sports club"],
    correctIndex: 0,
    explanation:
        "The Environmental Protection Agency (EPA) provides safe recycling guidance.",
    difficulty: "Hard",
  ),
  Question(
    question: "Which metal in old phones is considered valuable for recovery?",
    options: ["Gold", "Sand", "Iron ore", "Plastic"],
    correctIndex: 0,
    explanation: "Gold is commonly recovered from old phones and electronics.",
    difficulty: "Medium",
  ),
  Question(
    question: "Why are lithium batteries considered dangerous in landfills?",
    options: [
      "They can leak or catch fire",
      "They make gadgets last longer",
      "They absorb water",
      "They attract birds",
    ],
    correctIndex: 0,
    explanation:
        "Lithium batteries can short-circuit and ignite if damaged or improperly disposed.",
    difficulty: "Hard",
  ),
  Question(
    question: "What should you do with broken cords or chargers?",
    options: [
      "Recycle at e-waste centers",
      "Throw in regular trash",
      "Burn them",
      "Keep in water",
    ],
    correctIndex: 0,
    explanation:
        "Electronic accessories should be recycled properly to prevent hazards.",
    difficulty: "Easy",
  ),
  Question(
    question: "Which of these is a component of e-waste that is toxic?",
    options: ["Cadmium", "Sand", "Paper", "Cotton"],
    correctIndex: 0,
    explanation:
        "Cadmium is a heavy metal found in batteries and other electronics.",
    difficulty: "Medium",
  ),
  Question(
    question: "Which type of e-waste is most common in households?",
    options: [
      "Small appliances",
      "Industrial machinery",
      "Plastic containers",
      "Glass bottles",
    ],
    correctIndex: 0,
    explanation:
        "Small household electronics like toasters, irons, and phones are common e-waste.",
    difficulty: "Easy",
  ),
  Question(
    question: "What is the main goal of e-waste recycling?",
    options: [
      "Recover valuable materials and reduce pollution",
      "Increase landfill size",
      "Burn trash",
      "Store devices in basements",
    ],
    correctIndex: 0,
    explanation:
        "Recycling prevents environmental damage and recovers metals like gold and copper.",
    difficulty: "Easy",
  ),
  Question(
    question: "Why should old CRT TVs not be thrown in regular trash?",
    options: [
      "They contain lead and other toxins",
      "They are too big",
      "They are heavy",
      "They have plastic",
    ],
    correctIndex: 0,
    explanation: "CRT TVs contain leaded glass which is hazardous.",
    difficulty: "Medium",
  ),
  Question(
    question: "Which of the following is a benefit of reusing old electronics?",
    options: [
      "Reduces demand for new resources",
      "Increases pollution",
      "Consumes more energy",
      "Requires burning waste",
    ],
    correctIndex: 0,
    explanation:
        "Reusing electronics reduces resource extraction and energy use.",
    difficulty: "Easy",
  ),
];
