package flexygames


import flexygames.admin.SessionController
import grails.test.mixin.*

import org.junit.*

@TestFor(SessionController)
@Mock(Session)
class SessionControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/session/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.sessionInstanceList.size() == 0
        assert model.sessionInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.sessionInstance != null
    }

    void testSave() {
        controller.save()

        assert model.sessionInstance != null
        assert view == '/session/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/session/show/1'
        assert controller.flash.message != null
        assert Session.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/session/list'

        populateValidParams(params)
        def session = new Session(params)

        assert session.save() != null

        params.id = session.id

        def model = controller.show()

        assert model.sessionInstance == session
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/session/list'

        populateValidParams(params)
        def session = new Session(params)

        assert session.save() != null

        params.id = session.id

        def model = controller.edit()

        assert model.sessionInstance == session
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/session/list'

        response.reset()

        populateValidParams(params)
        def session = new Session(params)

        assert session.save() != null

        // test invalid parameters in update
        params.id = session.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/session/edit"
        assert model.sessionInstance != null

        session.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/session/show/$session.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        session.clearErrors()

        populateValidParams(params)
        params.id = session.id
        params.version = -1
        controller.update()

        assert view == "/session/edit"
        assert model.sessionInstance != null
        assert model.sessionInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/session/list'

        response.reset()

        populateValidParams(params)
        def session = new Session(params)

        assert session.save() != null
        assert Session.count() == 1

        params.id = session.id

        controller.delete()

        assert Session.count() == 0
        assert Session.get(session.id) == null
        assert response.redirectedUrl == '/session/list'
    }
}
