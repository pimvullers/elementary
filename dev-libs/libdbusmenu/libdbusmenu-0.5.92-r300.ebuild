# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdbusmenu/libdbusmenu-0.5.1-r300.ebuild,v 1.3 2011/11/28 22:37:34 zmedico Exp $

EAPI=4

PN_vala_version=0.14

inherit virtualx

DESCRIPTION="Library to pass menu structure across DBus"
HOMEPAGE="https://launchpad.net/dbusmenu"
SRC_URI="http://launchpad.net/dbusmenu/0.6/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="gtk +introspection test"

RDEPEND=">=dev-libs/glib-2.26
	dev-libs/dbus-glib
	dev-libs/libxml2
	gtk? ( x11-libs/gtk+:3 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.7 )
	!<${CATEGORY}/${PN}-0.5.1-r200"
DEPEND="${RDEPEND}
	test? (
		dev-libs/json-glib[introspection?]
		dev-util/dbus-test-runner
	)
	dev-lang/vala:${PN_vala_version}[vapigen]
	app-text/gnome-doc-utils
	dev-util/intltool
	dev-util/pkgconfig"

src_prepare() {
	# Drop DEPRECATED flags, bug #391103
	sed -i \
		-e 's:-D[A-Z_]*DISABLE_DEPRECATED:$(NULL):g' \
		{libdbusmenu-{glib,gtk},tests}/Makefile.{am,in} configure{,.ac} || die
}

src_configure() {
	export VALA_API_GEN="$(type -P vapigen-${PN_vala_version})"

	# note: --disable-dumper to avoid GTK+ 2.0
	econf \
		--docdir=/usr/share/doc/${PF} \
		--disable-static \
		$(use_enable gtk) \
		--disable-dumper \
		$(use_enable introspection) \
		$(use_enable test tests) \
		--with-html-dir=/usr/share/doc/${PF} \
		--with-gtk=3
}

src_test() {
	Xemake check
}

src_install() {
	emake -j1 DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README
	find "${ED}" -name '*.la' -exec rm -f {} +
}
