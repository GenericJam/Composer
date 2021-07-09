
import {Socket} from "phoenix"
import * as SurveyCreator from 'survey-creator'

let surveyContainer = document.getElementById("surveyCreatorContainer")

let surveySocket = new Socket("/survey-socket", {
    params: {token: window.userToken},
    logger: (kind, msg, data) => { console.log(`${kind}: ${msg}`, data) }
  })

  surveySocket.connect()
  
  // Now that you are connected, you can join channels with a topic:
  let surveyChannel = surveySocket.channel("survey:new", {})
  
  surveyChannel.on("survey_created", payload => {
    console.log("receive message")
    let messageItem = document.createElement("h2")
    messageItem.innerText = `${payload.body}`
    surveyContainer.replaceWith(messageItem);
  })
  
  surveyChannel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })
  

function saveSurvey() {
    const surveyJSON = surveyCreator.text;
    const csrf = surveyContainer.getAttribute("csrf")
    surveyChannel.push("new_survey", {body: {survey: surveyJSON, csrf}}, 10000)
  }


SurveyCreator.StylesManager.applyTheme('darkblue');
var options = {
  // Show the embedded survey tab. It is hidden by default
  showEmbeddedSurveyTab: true,
  // Show the test survey tab. It is shown by default
  showTestSurveyTab: true,
  // Show the JSON text editor tab. It is shown by default
  showJSONEditorTab: true,
  // Show the "Options" button menu. It is hidden by default
  showOptions: true,
};
// Pass the options into the constructor. It is an optional parameter.
const surveyCreator = new SurveyCreator.SurveyCreator(
  'surveyCreatorContainer',
  options
);
//set function on save callback
surveyCreator.saveSurveyFunc = saveSurvey;

export default surveySocket