package flexygames



import org.junit.*

import flexygames.admin.SessionGroupController;
import grails.test.mixin.*

@TestFor(SessionGroupController)
@Mock(SessionGroup)
class SessionGroupControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/sessionGroup/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.sessionGroupInstanceList.size() == 0
        assert model.sessionGroupInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.sessionGroupInstance != null
    }

    void testSave() {
        controller.save()

        assert model.sessionGroupInstance != null
        assert view == '/sessionGroup/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/sessionGroup/show/1'
        assert controller.flash.message != null
        assert SessionGroup.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/sessionGroup/list'

        populateValidParams(params)
        def sessionGroup = new SessionGroup(params)

        assert sessionGroup.save() != null

        params.id = sessionGroup.id

        def model = controller.show()

        assert model.sessionGroupInstance == sessionGroup
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/sessionGroup/list'

        populateValidParams(params)
        def sessionGroup = new SessionGroup(params)

        assert sessionGroup.save() != null

        params.id = sessionGroup.id

        def model = controller.edit()

        assert model.sessionGroupInstance == sessionGroup
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/sessionGroup/list'

        response.reset()

        populateValidParams(params)
        def sessionGroup = new SessionGroup(params)

        assert sessionGroup.save() != null

        // test invalid parameters in update
        params.id = sessionGroup.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/sessionGroup/edit"
        assert model.sessionGroupInstance != null

        sessionGroup.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/sessionGroup/show/$sessionGroup.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        sessionGroup.clearErrors()

        populateValidParams(params)
        params.id = sessionGroup.id
        params.version = -1
        controller.update()

        assert view == "/sessionGroup/edit"
        assert model.sessionGroupInstance != null
        assert model.sessionGroupInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/sessionGroup/list'

        response.reset()

        populateValidParams(params)
        def sessionGroup = new SessionGroup(params)

        assert sessionGroup.save() != null
        assert SessionGroup.count() == 1

        params.id = sessionGroup.id

        controller.delete()

        assert SessionGroup.count() == 0
        assert SessionGroup.get(sessionGroup.id) == null
        assert response.redirectedUrl == '/sessionGroup/list'
    }
}
