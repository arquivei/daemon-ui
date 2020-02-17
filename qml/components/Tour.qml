import QtQuick 2.12
import '../helpers/factory.js' as Factory

Item {
    id: root

    property var steps
    property var currentStepComponent
    property int stepIndex: 0

    function startTour() {
        const initialStep = steps[0];
        currentStepComponent = Factory.createSharedComponent('TourStep', initialStep.parent, initialStep);
        currentStepComponent.next.connect(nextStep);
        currentStepComponent.prev.connect(prevStep);
        currentStepComponent.close.connect(finishTour);
        currentStepComponent.start();
    }

    function finishTour() {
        if (currentStepComponent) {
            currentStepComponent.stop();
            currentStepComponent.destroy();
            stepIndex = 0
        }
    }

    function nextStep() {
        stepIndex++;
        currentStepComponent.destroy();
        const next = steps[stepIndex];
        if (next) {
            currentStepComponent = Factory.createSharedComponent('TourStep', next.parent, next);
            currentStepComponent.next.connect(nextStep);
            currentStepComponent.prev.connect(prevStep);
            currentStepComponent.close.connect(finishTour);
            currentStepComponent.start();
        } else {
            stepIndex = 0;
        }
    }

    function prevStep() {
        stepIndex--;
        currentStepComponent.destroy();
        const prev = steps[stepIndex];
        if (prev) {
            currentStepComponent = Factory.createSharedComponent('TourStep', prev.parent, prev);
            currentStepComponent.next.connect(nextStep);
            currentStepComponent.prev.connect(prevStep);
            currentStepComponent.close.connect(finishTour);
            currentStepComponent.start();
        } else {
            stepIndex = 0;
        }
    }
}
