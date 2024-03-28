import Handlebars from 'handlebars';
import fs from 'node:fs/promises';
import prolog from 'tau-prolog';
import loader from 'tau-prolog/modules/lists.js';
loader(prolog);

const template = await fs.readFile('./template.hbs', 'utf-8');

const compiledTemplate = Handlebars.compile(template);
// console.log(compiledTemplate({ person: 'TEST' }));

const session = prolog.create();

const error = (error) => console.log('ERROR:', session.format_error(error));

const generateAnswers = () => {};

session.consult('./santa.pl', {
  success: () => {
    session.query('santa(Result).', {
      success: (goal) => {
        console.log('GOAL: ', goal);
        session.answer({
          success: (answer) => {
            console.log('ANSWER: ', session.format_answer(answer));
          },
          error,
        });
      },
      error,
    });
  },
  error,
});
