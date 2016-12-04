import difflib
import unittest
import subprocess
import os


program = "TrainAndTest"
images = os.listdir("test_images")[1:]

ratios = []


# def create_breakout(result, word):
#     if result != word:
#         print('{} => {}'.format(result, word))
#         for i, s in enumerate(difflib.ndiff(result,  word)):
#             if s[0] == ' ':
#                 continue
#             elif s[0] == '-':
#                 print(u'Delete "{}" from position {}'.format(s[-1], i))
#             elif s[0] == '+':
#                 print(u'Add "{}" to position {}'.format(s[-1], i))
#         print()


# this is the spec test case.
class TestBench_Uppercase(unittest.TestCase):

    def test_unique_letters(self):
        sentence = "THE QUICK BROWN FOX JUMP OVER LAZY DOG".split()
        for image in images:
            word = ''.join([i for i in image[:-4] if not i.isdigit()])
            if word in sentence:
                with self.subTest(CASE=image):
                    image_path = "test_images/" + image
                    out = subprocess.check_output(["./TrainAndTest", image_path]).decode("utf-8")
                    result = out.split(" = ")[1].rstrip()
                    # create_breakout(result, word)
                    ratio = difflib.SequenceMatcher(None, result, word).ratio()
                    ratios.append((ratio, len(word)))
                    self.assertEqual(result, word)

    # def test_rick_roll(self):
    #     sentence = "RICK ROLL NEVER GONNA GIVE YOU UP LET DOWN RUN AROUND AND YOU".split()
    #     for image in images:
    #         word = ''.join([i for i in image[:-4] if not i.isdigit()])
    #         if word in sentence:
    #             with self.subTest(CASE=image):
    #                 image_path = "test_images/" + image
    #                 out = subprocess.check_output(["./TrainAndTest", image_path]).decode("utf-8")
    #                 result = out.split(" = ")[1].rstrip()
    #                 create_breakout(result, word)
    #                 self.assertEqual(result, word)

    # def test_team_names(self):
    #     sentence = "JENNA ERIC LUKE OSAMA DOR".split()
    #     for image in images:
    #         word = ''.join([i for i in image[:-4] if not i.isdigit()])
    #         if word in sentence:
    #             with self.subTest(CASE=image):
    #                 image_path = "test_images/" + image
    #                 out = subprocess.check_output(["./TrainAndTest", image_path]).decode("utf-8")
    #                 result = out.split(" = ")[1].rstrip()
    #                 create_breakout(result, word)
    #                 self.assertEqual(result, word)


if __name__ == '__main__':
    unittest.main()
    print(ratios)
