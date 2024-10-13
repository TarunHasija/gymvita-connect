class GraphLimits {
  static const Map<String, Map<String, dynamic>> bodyPartLimits = {
    'bicep': {'upperLimit': 50, 'lowerLimit': 0, 'unit': 'cm'},
    'tricep': {'upperLimit': 50, 'lowerLimit': 0, 'unit': 'cm'},
    'weight': {'upperLimit': 120, 'lowerLimit': 40, 'unit': 'kg'},
    'height': {'upperLimit': 190, 'lowerLimit': 140, 'unit': 'cm'},
    'hips': {'upperLimit': 130, 'lowerLimit': 70, 'unit': 'cm'},
    'thighs': {'upperLimit': 80, 'lowerLimit': 30, 'unit': 'cm'},
    'chest': {'upperLimit': 130, 'lowerLimit': 50, 'unit': 'cm'},
    'waist': {'upperLimit': 130, 'lowerLimit': 60, 'unit': 'cm'},
  };

  // Fallback/default values in case the body part isn't defined
  static const double defaultUpperLimit = 100;
  static const double defaultLowerLimit = 40;
  static const String defaultUnit = 'cm';
}
