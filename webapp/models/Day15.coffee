Day = require './abstract/Day.coffee'

class Day15 extends Day
  puzzle1Completed: true
  puzzle2Completed: true
  name: 'Science for Hungry People'

  getPuzzle1Inputs: () ->
    [
      {label: 'Ingredients', type: 'textarea', name: 'ingredients'}
    ]

  runPuzzle1: (inputs) ->
    [ingredientData, ingredients] = @parseIngredients inputs.ingredients

    getHighestScore = (usedIngredients, remainingTeaspoons, ingredientIndex) ->
      if Object.keys(usedIngredients).length is ingredients.length
        totals =
          capacity: 0
          durability: 0
          flavour: 0
          texture: 0
        for name, amount of usedIngredients
          totals.capacity += ingredientData[name].capacity * amount
          totals.durability += ingredientData[name].durability * amount
          totals.flavour += ingredientData[name].flavour * amount
          totals.texture += ingredientData[name].texture * amount

        totals.capacity = 0 if totals.capacity < 0
        totals.durability = 0 if totals.durability < 0
        totals.flavour = 0 if totals.flavour < 0
        totals.texture = 0 if totals.texture < 0

        return totals.capacity * totals.durability * totals.flavour * totals.texture

      highestScore = NaN

      newUsedIngredients = JSON.parse JSON.stringify(usedIngredients)
      ingredient = ingredients[ingredientIndex]
      if Object.keys(usedIngredients).length + 1 is ingredients.length
        newUsedIngredients[ingredient] = remainingTeaspoons
        score = getHighestScore newUsedIngredients, 0, ingredientIndex + 1
        highestScore = score if isNaN(highestScore) or highestScore < score
      else
        for i in [0..remainingTeaspoons]
          newUsedIngredients[ingredient] = i
          score = getHighestScore newUsedIngredients, (remainingTeaspoons - i), ingredientIndex + 1
          highestScore = score if isNaN(highestScore) or highestScore < score

      highestScore

    getHighestScore {}, 100, 0

  getPuzzle1Code: () ->
    code = [
      @parseIngredients.toString()
      @runPuzzle1.toString()
    ]

    code.join '\n'

  getPuzzle2Inputs: () ->
    @getPuzzle1Inputs()

  runPuzzle2: (inputs) ->
    [ingredientData, ingredients] = @parseIngredients inputs.ingredients

    getHighestScore = (usedIngredients, remainingTeaspoons, ingredientIndex) ->
      if Object.keys(usedIngredients).length is ingredients.length
        totals =
          capacity: 0
          durability: 0
          flavour: 0
          texture: 0
          calories: 0
        for name, amount of usedIngredients
          totals.capacity += ingredientData[name].capacity * amount
          totals.durability += ingredientData[name].durability * amount
          totals.flavour += ingredientData[name].flavour * amount
          totals.texture += ingredientData[name].texture * amount
          totals.calories += ingredientData[name].calories * amount

        return 0 if totals.calories isnt 500

        totals.capacity = 0 if totals.capacity < 0
        totals.durability = 0 if totals.durability < 0
        totals.flavour = 0 if totals.flavour < 0
        totals.texture = 0 if totals.texture < 0

        return totals.capacity * totals.durability * totals.flavour * totals.texture

      highestScore = NaN

      newUsedIngredients = JSON.parse JSON.stringify(usedIngredients)
      ingredient = ingredients[ingredientIndex]
      if Object.keys(usedIngredients).length + 1 is ingredients.length
        newUsedIngredients[ingredient] = remainingTeaspoons
        score = getHighestScore newUsedIngredients, 0, ingredientIndex + 1
        highestScore = score if isNaN(highestScore) or highestScore < score
      else
        for i in [0..remainingTeaspoons]
          newUsedIngredients[ingredient] = i
          score = getHighestScore newUsedIngredients, (remainingTeaspoons - i), ingredientIndex + 1
          highestScore = score if isNaN(highestScore) or highestScore < score

      highestScore

    getHighestScore {}, 100, 0

  getPuzzle2Code: () ->
    code = [
      @parseIngredients.toString()
      @runPuzzle2.toString()
    ]

    code.join '\n'

  parseIngredients: (input) ->
    ingredientData = {}
    ingredients = []
    strings = input.split '\n'

    pattern = /^(\w+): capacity ([-]*\d+), durability ([-]*\d+), flavor ([-]*\d+), texture ([-]*\d+), calories ([-]*\d+)$/i
    for string in strings
      matches = pattern.exec string
      ingredientData[matches[1]] =
        capacity: parseInt matches[2]
        durability: parseInt matches[3]
        flavour: parseInt matches[4]
        texture: parseInt matches[5]
        calories: parseInt matches[6]

      ingredients.push matches[1]

    [ingredientData, ingredients]

module.exports =
  name: 'Day15'
  instance: Day15