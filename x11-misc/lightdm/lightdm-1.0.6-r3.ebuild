# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lightdm/lightdm-1.0.6-r3.ebuild,v 1.1 2011/11/19 20:27:34 hwoarang Exp $

EAPI=4
inherit autotools eutils pam

DESCRIPTION="A lightweight display manager"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/LightDM"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz
	mirror://gentoo/introspection-20110205.m4.tar.bz2
	gtk? ( http://dev.gentoo.org/~hwoarang/distfiles/${PN}-gentoo-patch.tar.gz )"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="branding +gtk +introspection qt4"

RDEPEND="dev-libs/glib:2
	virtual/pam
	x11-libs/libxklavier
	x11-libs/libX11
	dev-libs/libxml2
	gtk? ( x11-libs/gtk+:3
		x11-themes/gnome-themes-standard
		x11-themes/gnome-icon-theme )
	introspection? ( dev-libs/gobject-introspection )
	qt4? ( x11-libs/qt-core:4
		x11-libs/qt-dbus:4 )
	sys-apps/accountsservice"
DEPEND="${RDEPEND}
	dev-lang/vala:0.12
	dev-util/intltool
	dev-util/pkgconfig
	gnome-base/gnome-common
	sys-devel/gettext"

REQUIRED_USE="branding? ( gtk ) || ( gtk qt4 )"
DOCS=( NEWS )

src_prepare() {
	sed -i -e "/minimum-uid/s:500:1000:" data/users.conf || die
	sed -i -e "s:gtk+-3.0:gtk+-2.0:" configure.ac || die
	epatch "${FILESDIR}"/session-wrapper-${PN}.patch
	epatch "${FILESDIR}"/${PN}-${PV}-automake-1.11.2.patch

	if has_version dev-libs/gobject-introspection; then
		eautoreconf
	else
		AT_M4DIR=${WORKDIR} eautoreconf
	fi
}

src_configure() {
	# Maybe in the future, we can support some automatic session and user
	# recognition. Until then, use default values
	local default=gnome greeter= user=root

	# gtk has higher priority because Qt4 interface sucks :)
	use qt4 && greeter=lightdm-qt-greeter
	use gtk && greeter=lightdm-gtk-greeter

	# Let user know how lightdm is configured
	einfo "Gentoo configuration"
	einfo "Default greeter: ${greeter}"
	einfo "Default session: ${default}"
	einfo "Greeter user: ${user}"

	# do the actual configuration
	econf --localstatedir=/var \
		--disable-static \
		$(use_enable introspection) \
		$(use_enable qt4 liblightdm-qt) \
		$(use_enable qt4 qt-greeter) \
		$(use_enable gtk gtk-greeter) \
		--with-user-session=${default} \
		--with-greeter-session=${greeter} \
		--with-greeter-user=${user} \
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
}

src_install() {
	default

	# Install missing files
	insinto /etc/${PN}/
	doins "${S}"/data/{users,keys}.conf
	doins "${FILESDIR}"/Xsession
	fperms +x /etc/${PN}/Xsession
	# remove .la files
	find "${ED}" -name "*.la" -exec rm -rf {} +
	rm -Rf "${ED}"/etc/init || die

	if use gtk; then
		insinto /etc/${PN}/
		doins "${WORKDIR}"/${PN}-gtk-greeter.conf
		if use branding; then
			insinto /usr/share/${PN}/backgrounds/
			doins "${WORKDIR}"/gentoo1024x768.png
			sed -i -e "/background/s:=.*:=/usr/share/${PN}/backgrounds/gentoo1024x768.png:" \
				"${D}"/etc/${PN}/${PN}-gtk-greeter.conf || die
		fi
	fi

	dopamd "${FILESDIR}"/${PN}
	dopamd "${FILESDIR}"/${PN}-autologin
}

pkg_postinst() {
	elog
	elog "Even though the default /etc/${PN}/${PN}.conf will work for"
	elog "most users, make sure you configure it to suit your needs"
	elog "before using ${PN} for the first time."
	elog "You can test the configuration file using the following"
	elog "command: ${PN} --test-mode -c /etc/${PN}/${PN}.conf. This"
	elog "requires xorg-server to be built with the 'kdrive' useflag."
	elog
}
