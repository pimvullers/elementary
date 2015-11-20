# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

VALA_MIN_API_VERSION=0.20

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE='threads(+)'

inherit eutils fdo-mime gnome2-utils pax-utils python-any-r1 cmake-utils vala

DESCRIPTION="A lightweight web browser based on WebKitGTK+"
HOMEPAGE="http://www.midori-browser.org/"
SRC_URI="http://www.${PN}-browser.org/downloads/${PN}_${PV}_all_.tar.bz2"

LICENSE="LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips x86 ~x86-fbsd"
IUSE="doc +granite +jit nls zeitgeist"

RDEPEND="
	>=app-crypt/gcr-3[gtk]
	>=dev-db/sqlite-3.6.19:3
	>=dev-libs/glib-2.32.3
	dev-libs/libxml2
	>=net-libs/libsoup-2.38:2.4
	>=net-libs/libsoup-gnome-2.38:2.4
	>=x11-libs/libnotify-0.7
	x11-libs/libXScrnSaver
	x11-libs/gtk+:3
	net-libs/webkit-gtk:3[jit=]
	granite? ( >=x11-libs/granite-0.2 )
	zeitgeist? ( >=dev-libs/libzeitgeist-0.3.14 )"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	$(vala_depend)
	dev-util/intltool
	gnome-base/librsvg
	nls? ( sys-devel/gettext )
	doc? ( dev-util/gtk-doc )"

S=${WORKDIR}

pkg_setup() {
	python-any-r1_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-fix-webkit2-build-breakage.patch"
	epatch_user

	vala_src_prepare
	cmake-utils_src_prepare

	sed -i -e '/^install/s:COPYING:HACKING TODO TRANSLATE:' CMakeLists.txt || die
	use nls || sed -i -e 's/add_subdirectory (po)//' CMakeLists.txt
}

src_configure() {
	strip-linguas -i po

	local mycmakeargs=(
		-DCMAKE_INSTALL_DOCDIR=/usr/share/doc/${PF}
		$(cmake-utils_use_use doc APIDOCS)
		$(cmake-utils_use_use granite)
		$(cmake-utils_use_use zeitgeist)
		-DVALA_EXECUTABLE="${VALAC}"
		-DUSE_GTK3=ON
		-DHALF_BRO_INCOM_WEBKIT2=YES
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	local jit_is_enabled
	has_version 'net-libs/webkit-gtk:3[jit]' && jit_is_enabled=yes
	[[ ${jit_is_enabled} == yes ]] && pax-mark -m "${ED}"/usr/bin/${PN} #480290
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
