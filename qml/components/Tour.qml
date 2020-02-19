import QtQuick 2.12
import '../helpers/factory.js' as Factory

Item {
    id: root

    property var steps
    property var currentStepComponent
    property int stepIndex: 0

    signal stepsCompleted()

    function start() {
        const initialStep = steps[0];
        currentStepComponent = Factory.createSharedComponent('TourStep', initialStep.parent, initialStep);
        currentStepComponent.next.connect(next);
        currentStepComponent.prev.connect(prev);
        currentStepComponent.close.connect(finish);
        currentStepComponent.start();
    }

    function finish() {
        if (currentStepComponent) {
            currentStepComponent.stop();
            currentStepComponent.destroy();
            stepIndex = 0
        }
    }

    function next() {
        stepIndex++;
        currentStepComponent.destroy();
        const nextStep = steps[stepIndex];
        if (nextStep) {
            currentStepComponent = Factory.createSharedComponent('TourStep', nextStep.parent, nextStep);
            currentStepComponent.next.connect(next);
            currentStepComponent.prev.connect(prev);
            currentStepComponent.close.connect(finish);
            currentStepComponent.start();
        } else {
            stepIndex = 0;
            stepsCompleted();
        }
    }

    function prev() {
        stepIndex--;
        currentStepComponent.destroy();
        const prevStep = steps[stepIndex];
        if (prevStep) {
            currentStepComponent = Factory.createSharedComponent('TourStep', prevStep.parent, prevStep);
            currentStepComponent.next.connect(next);
            currentStepComponent.prev.connect(prev);
            currentStepComponent.close.connect(finish);
            currentStepComponent.start();
        } else {
            stepIndex = 0;
        }
    }
}
