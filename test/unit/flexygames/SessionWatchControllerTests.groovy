package flexygames



import org.junit.*

import flexygames.admin.SessionWatchController;
import grails.test.mixin.*

@TestFor(SessionWatchController)
@Mock(SessionWatch)
class SessionWatchControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/sessionWatch/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.sessionWatchInstanceList.size() == 0
        assert model.sessionWatchInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.sessionWatchInstance != null
    }

    void testSave() {
        controller.save()

        assert model.sessionWatchInstance != null
        assert view == '/sessionWatch/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/sessionWatch/show/1'
        assert controller.flash.message != null
        assert SessionWatch.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/sessionWatch/list'

        populateValidParams(params)
        def sessionWatch = new SessionWatch(params)

        assert sessionWatch.save() != null

        params.id = sessionWatch.id

        def model = controller.show()

        assert model.sessionWatchInstance == sessionWatch
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/sessionWatch/list'

        populateValidParams(params)
        def sessionWatch = new SessionWatch(params)

        assert sessionWatch.save() != null

        params.id = sessionWatch.id

        def model = controller.edit()

        assert model.sessionWatchInstance == sessionWatch
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/sessionWatch/list'

        response.reset()

        populateValidParams(params)
        def sessionWatch = new SessionWatch(params)

        assert sessionWatch.save() != null

        // test invalid parameters in update
        params.id = sessionWatch.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/sessionWatch/edit"
        assert model.sessionWatchInstance != null

        sessionWatch.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/sessionWatch/show/$sessionWatch.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        sessionWatch.clearErrors()

        populateValidParams(params)
        params.id = sessionWatch.id
        params.version = -1
        controller.update()

        assert view == "/sessionWatch/edit"
        assert model.sessionWatchInstance != null
        assert model.sessionWatchInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/sessionWatch/list'

        response.reset()

        populateValidParams(params)
        def sessionWatch = new SessionWatch(params)

        assert sessionWatch.save() != null
        assert SessionWatch.count() == 1

        params.id = sessionWatch.id

        controller.delete()

        assert SessionWatch.count() == 0
        assert SessionWatch.get(sessionWatch.id) == null
        assert response.redirectedUrl == '/sessionWatch/list'
    }
}
